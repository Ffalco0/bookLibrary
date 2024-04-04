//
//  BookRaw.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 30/03/24.
//

import SwiftUI

struct BookRaw: View {
    let doc: Doc
    @State var downloadedImages: [[String]: UIImage] = [:] // State to store downloadedimages
    var body: some View {
        VStack(alignment:.leading) {
            HStack{
                Spacer()
                if let image = downloadedImages[doc.isbn ?? [""]] {
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
            Text("Title: " + (doc.title ?? "No Title"))
            Text("Author: " + (doc.authorName?.last ?? "No author"))
            Text("ISBN: " + (doc.isbn?.first ?? "No ISBN"))
            Text("Pages: \(doc.numberOfPagesMedian ?? 0)")
        }
        .task {
            do {
                
                if downloadedImages[doc.isbn ?? [""]] == nil {
                    let downloadedImage = try await downloadImage(from: URL(string: "https://covers.openlibrary.org/b/isbn/\(doc.isbn?.first ?? "")-M.jpg")!
                    )
                    downloadedImages[doc.isbn ?? [""]] = downloadedImage
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
}

