//
//  BookSearch.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 02/04/24.
//

import SwiftUI

struct BookSearch: View {
    @StateObject var vm = BookListViewModel()
    
    var body: some View {
        NavigationView{
            Group{
                if vm.searchText.isEmpty{
                    BookPlaceholder(searchTerm: $vm.searchText)
                }else{
                    BookList(vm: vm)
                }
            }
        }
        .searchable(text: $vm.searchText)
        .navigationTitle("Search Book")
    }
}


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

#Preview {
    BookSearch()
}
