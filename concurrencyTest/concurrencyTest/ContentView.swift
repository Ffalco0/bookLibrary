//
//  ContentView.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 25/03/24.
//

import SwiftUI
import Combine


struct ContentView: View {
    @State private var book: Welcome?
    @State private var text: String = ""
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width:200, height: 200)
                    .padding()
                
                if let book = book {
                    if let firstDoc = book.docs.first { // Assuming the first doc contains the book details
                       
                       
                       
                       
                        
                    } else {
                        Text("No book data found.")
                    }
                }
                
            }
            .task{
                do{
                    book = try await getBook()
                }catch BError.invalidURL{
                    print("invalid url")
                }catch BError.invalidData{
                    print("invalid data")
                }catch BError.badResponse{
                    print("bad response")
                }catch {
                    print("Error")
                }
            }
            Spacer()
        }
        //.searchable(text: $text ,prompt: "Search")
        
    }
    
}


func getBook() async throws -> Welcome {
    let urlString = "https://openlibrary.org/search.json?q=the+lord+of+the+rings"
    guard let url = URL(string: urlString) else{
        throw BError.invalidURL
    }
    let (data,response) = try await URLSession.shared.data(from: url)
    
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw BError.badResponse
    }
    
    do{
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let dubug = try decoder.decode(Welcome.self, from: data)
        return try decoder.decode(Welcome.self, from: data)
    } catch{
        throw BError.invalidData
    }
    
}

#Preview {
    ContentView()
}


  
