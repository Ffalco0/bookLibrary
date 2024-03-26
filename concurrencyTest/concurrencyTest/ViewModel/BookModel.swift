//
//  BookModel.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 26/03/24.
//
import Foundation

struct Books: Codable{
    let object: [BookObj]
}

struct BookObj: Codable{
    let start: Int
    let numFound: Int
    let docs: [doc]
}

struct doc: Codable {
    let title: String?
    let author_nam: [String]?
    let cover: [String: String]?
}

enum BError: Error {
    case invalidURL
    case badResponse
    case invalidData
}
