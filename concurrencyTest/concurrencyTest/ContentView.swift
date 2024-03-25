//
//  ContentView.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 25/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var text: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .frame(width:200, height: 200)
                    .padding()
                Text("Put here the sample text")
            }
            .padding()
        }.searchable(text: $text ,prompt: "scrivi")
    }
    
}

#Preview {
    ContentView()
}

