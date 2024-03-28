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
                TextField("Search", text: $searchText, onCommit: search)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .disableAutocorrection(true)
                
                if let firstBook = book?.docs?.first {
                    RoundedRectangle(cornerRadius: 25.0)
                        .frame(width:200, height: 200)
                        .padding()
                    Text(firstBook.title ?? "No Title")
                        .font(.title)
                    Text(firstBook.authorName?.isEmpty ?? true ? "No Author" : firstBook.authorName?.joined(separator: ", ") ?? "No Author")
                    Text(firstBook.subtitle ?? "No subtitle")
                    Text(firstBook.isbn?.first ?? "No ISBN")
                    Text("Pages: \(firstBook.numberOfPagesMedian ?? 0)")
                } else {
                    Text("No Results")
                }
                Spacer()
            }
            .navigationTitle("Book Details")
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
    print("inside getBook")
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


  
