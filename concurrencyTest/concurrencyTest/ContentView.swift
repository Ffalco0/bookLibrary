//
//  ContentView.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 25/03/24.
//

import SwiftUI
import Combine


struct ContentView: View {
    var body: some View {
        BookSearch()
    }
}


/*
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
 }*/

/*
private func search() {
    guard !searchText.isEmpty else {
        return
    }
    
    isSearching = true
    Task {
        do {
            print("start")
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

*/
