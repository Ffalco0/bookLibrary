//
//  BookModel.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 26/03/24.
//
import Foundation

// MARK: - Book
struct Book: Codable {
  let numFound, start: Int?
  let numFoundExact: Bool?
  let docs: [Doc]
  let bookNumFound: Int?
  let q: String?
}

// MARK: - Doc
struct Doc: Codable,Identifiable  {
    let authorAlternativeName, authorKey, authorName, contributor: [String]?
    let coverEditionKey: String?
    let coverI: Int?
    let ddc: [String]?
    let ebookAccess: String?
    let ebookCountI, editionCount: Int?
    let editionKey: [String]?
    let firstPublishYear: Int?
    let firstSentence: [String]?
    let hasFulltext: Bool?
    let ia, iaCollection: [String]?
    let iaCollectionS: String?
    let isbn: [String]?
    let key: String?
    let language: [String]?
    let lastModifiedI: Int?
    let lcc, lccn: [String]?
    let lendingEditionS, lendingIdentifierS: String?
    let numberOfPagesMedian: Int?
    let oclc: [String]?
    let printdisabledS: String?
    let publicScanB: Bool?
    let publishDate, publishPlace: [String]?
    let publishYear: [Int]?
    let publisher, seed: [String]?
    let title, titleSort, titleSuggest: String?
    let type: String?
    let idLibrarything, idGoodreads, idAmazon, idDepósitoLegal: [String]?
    let idAlibrisID, idGoogle, idPaperbackSwap, idWikidata: [String]?
    let idOverdrive, idCanadianNationalLibraryArchive, subject, place: [String]?
    let time, person, iaLoadedID, iaBoxID: [String]?
    let ratingsAverage, ratingsSortable: Double?
    let ratingsCount, ratingsCount1, ratingsCount2, ratingsCount3: Int?
    let ratingsCount4, ratingsCount5, readinglogCount, wantToReadCount: Int?
    let currentlyReadingCount, alreadyReadCount: Int?
    let publisherFacet, personKey, placeKey, timeFacet: [String]?
    let personFacet, subjectFacet: [String]?
    let version: Double?
    let placeFacet: [String]?
    let lccSort: String?
    let authorFacet, subjectKey, timeKey: [String]?
    let ddcSort: String?
    let idNla, idAmazonCoUkAsin, idAmazonCAAsin, idAmazonDeAsin: [String]?
    let idBetterWorldBooks, idBritishNationalBibliography, idAmazonItAsin, idBcid: [String]?
    let idScribd, idHathiTrust, idBritishLibrary, idBibliothèqueNationaleDeFrance: [String]?
    let idLibris, idDnb: [String]?
    let subtitle: String?
    
    var id: String {
        return "\(title ?? "No title")-\(firstPublishYear ?? 0)-\(coverEditionKey ?? "No coverKey")"
    }
}


//MARK: - Error
enum BError: Error {
    case invalidURL
    case badResponse
    case invalidData
    case emptySearch
}


