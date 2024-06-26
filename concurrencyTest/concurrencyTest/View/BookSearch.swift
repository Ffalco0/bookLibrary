//
//  BookSearch.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 02/04/24.
//

import SwiftUI

struct BookSearch: View {
    @ObservedObject var vm: BookListViewModel
    
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
        
    }
}



