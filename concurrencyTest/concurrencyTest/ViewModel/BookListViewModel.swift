//
//  BookListViewModel.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 02/04/24.
//

import Foundation
import SwiftUI
import Combine


class BookListViewModel: ObservableObject {
    
    @Published var searchText: String =  ""
    @Published var book: [Doc] = [Doc]()
    
    var cancellables = Set<AnyCancellable>()
   
    init() {
        $searchText
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink{[weak self] term in
                self?.book = []
                self?.fetchBook(for: term)
            }.store(in: &cancellables)
    }
    
    func loadMore() {
        fetchBook(for: searchText)
    }
    
    func fetchBook(for searchText: String) {
        
        guard !searchText.isEmpty else {
            return
        }
        guard let urlString = URL(string: "https://openlibrary.org/search.json?q=\(searchText)&limit=10") else { return }
        print("start fetching data for \(searchText)")
        
        URLSession.shared.dataTask(with: urlString){ data, response, error in
            if let error = error{
                print("url session error: \(error.localizedDescription)")
            } else if let data = data {
                do{
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let result = try decoder.decode(Book.self, from: data)
                    DispatchQueue.main.async {
                        for book in result.docs{
                            self.book.append(book)
                            print("fetched \(result)")
                        }
                    }
                }catch{
                    print("decoding error \(error)")
                }
            }
        }.resume()
    
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
/*
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
*/
