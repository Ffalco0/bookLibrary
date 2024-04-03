//
//  BookList.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 02/04/24.
//

import SwiftUI

struct BookList: View {
    @ObservedObject var vm: BookListViewModel
    @State var downloadedImages: [[String]: UIImage] = [:] // State to store downloaded images
    var body: some View {
        List{
            if vm.book.isEmpty{
                Text("Searching")
                ProgressView()
                    .frame(width: 500,height: 500)
            }else{
                ForEach(vm.book) { book in
                    HStack{
                        Spacer()
                        if let image = downloadedImages[book.isbn ?? [""]] {
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
                    BookRaw(doc:book)
                    Button(action: {
                        print("this book is set as favourite \(book.title ?? "")")
                    }, label: {
                        Text("Set as fovourite")
                    })
                }.task {
                    do {
                        for firstBook in vm.book {
                            if downloadedImages[firstBook.isbn ?? [""]] == nil {
                                let downloadedImage = try await downloadImage(from: URL(string: "https://covers.openlibrary.org/b/isbn/\(firstBook.isbn?.first ?? "")-M.jpg")!
                                )
                                downloadedImages[firstBook.isbn ?? [""]] = downloadedImage
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
                }
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

#Preview {
    BookList(vm: BookListViewModel())
}
