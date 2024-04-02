//
//  BookRaw.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 30/03/24.
//

import SwiftUI

struct BookRaw: View {
    let doc: Doc
    
    var body: some View {
        
        VStack(alignment:.leading) {
            Text("Title: " + (doc.title ?? "No Title"))
            Text("Author: " + (doc.authorName?.last ?? "No author"))
            Text("ISBN: " + (doc.isbn?.first ?? "No ISBN"))
            Text("Pages: \(doc.numberOfPagesMedian ?? 0)")
        }
    }
}

