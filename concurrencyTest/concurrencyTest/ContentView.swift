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

                List{
                    ForEach(0..<(book?.docs?.count ?? 0), id: \.self){ index in
                        if let firstBook = book?.docs?[index] {
                            AsyncImage(url: URL(string: "https://covers.openlibrary.org/b/isbn/\(firstBook.isbn)-M.jpg")) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            Text(firstBook.title ?? "No Title")
                                .font(.title)
                            Text(firstBook.authorName?.isEmpty ?? true ? "No Author" : firstBook.authorName?.joined(separator: ", ") ?? "No Author")
                            Text(firstBook.subtitle ?? "No subtitle")
                            Text(firstBook.isbn?.first ?? "No ISBN")
                            Text("Pages: \(firstBook.numberOfPagesMedian ?? 0)")

                        } else {
                            Text("No Results")
                        }
                    }
                }
                
              
                Spacer()
            }
            .navigationTitle("Search for Books")
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



