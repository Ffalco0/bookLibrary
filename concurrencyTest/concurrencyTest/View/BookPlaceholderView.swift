//
//  BookPlaceholderView.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 03/04/24.
//

import SwiftUI

struct BookPlaceholder: View {
    
    @Binding var searchTerm: String
    let suggestions = ["This savage song", "the lord of the rings", "pride and prejudice"]
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text("Trending")
                .font(.title)
            ForEach(suggestions, id: \.self) { text in
                Button {
                    searchTerm = text
                } label: {
                    Text(text)
                        .font(.title2)
                }

            }
            
        }
    }
}
