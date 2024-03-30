//
//  ContentView.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 25/03/24.
//

import SwiftUI
import Combine


struct ContentView: View {
    @State private var searchText = ""
    @State private var book: Book?
    @State private var isSearching = false
    
    @State private var downloadedImages: [[String]: UIImage] = [:] // State to store downloaded images
    @State private var cancellables = Set<AnyCancellable>() // Set to store subscriptions


    
    var body: some View {
        NavigationView {
            VStack {
                HStack{
                    TextField("Search", text: $searchText)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .disableAutocorrection(true)
                        
                    
                    Button(action: {
                        search()
                    }, label: {
                        Image(systemName: "magnifyingglass")
                    })
                    .padding()
                }
                
                if searchText.isEmpty{
                    Text("Search for Your Book!!")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                }else{
                    List{
                        ForEach(0..<(book?.docs?.count ?? 0), id: \.self){ index in
                            if let firstBook = book?.docs?[index] {
                                
                                HStack{
                                    Spacer()
                                    if let image = downloadedImages[firstBook.isbn ?? [""]] {
                                        // Display downloaded image
                                        Image(uiImage: image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 200, height: 200)
                                            .frame(width: 100) // Adjust frame size
                                    } else {
                                        ProgressView()
                                            .frame(width: 100) // Adjust frame size
                                    }
                                    Spacer()
                                }
                                
                                VStack(alignment:.leading){
                                    Text(firstBook.title ?? "No Title")
                                        .font(.title)
                                    Text(firstBook.authorName?.isEmpty ?? true ? "No Author" : firstBook.authorName?.joined(separator: ", ") ?? "No Author")
                                    Text("ISBN: " + (firstBook.isbn?.first ?? "No ISBN"))
                                    Text("Pages: \(firstBook.numberOfPagesMedian ?? 0)")
                                }
                                
                            } else {
                                Text("No Results")
                            }
                        }
                    }
                }
                Spacer()
            }
            .navigationTitle("Search")
        }
    }
    
    private func search() {
        guard !searchText.isEmpty else {
            return
        }
        
        isSearching = true
        Task {
            do {
                book = try await getBook(searchBook: searchText)
                // Update downloadedImages state for each book
                if let book = book {
                    for firstBook in book.docs ?? [] {
                        if downloadedImages[firstBook.isbn ?? [""]] == nil {
                            let downloadedImage = try await downloadImage(from: URL(string: "https://covers.openlibrary.org/b/isbn/\(firstBook.isbn?.first ?? "")-M.jpg")!)
                            downloadedImages[firstBook.isbn ?? [""]] = downloadedImage
                        }
                    }
                }
            } catch BError.invalidURL {
                print("invalid url")
            } catch BError.invalidData {
                print("invalid data")
            } catch BError.badResponse {
                print("bad response")
            } catch {
                print("Error")
            }
            isSearching = false
        }
    }
    
    
   
}


func downloadImage(from url: URL) async throws -> UIImage {
  let (data, response) = try await URLSession.shared.data(from: url)

  guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
    throw BError.badResponse // Custom error for bad response
  }

  guard let image = UIImage(data: data) else {
      throw BError.invalidData  // Custom error for invalid image data
  }

  return image
}




func getBook(searchBook: String) async throws -> Book {
    let urlString = "https://openlibrary.org/search.json?q=\(searchBook)"
    guard let url = URL(string: urlString) else {
        throw BError.invalidURL
    }
    let (data, response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw BError.badResponse
    }
    do {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let book = try decoder.decode(Book.self, from: data)
        return book
    } catch {
        throw BError.invalidData
    }
}




#Preview {
    ContentView()
}



