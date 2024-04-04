//
//  ContentView.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 25/03/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = BookListViewModel()
    
    var body: some View {
        TabView {
            BookSearch(vm: vm)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            StarredBookList(vm: vm)
                .tabItem {
                    Label("Starred", systemImage: "star.fill")
                }
            
        }
    }
}


