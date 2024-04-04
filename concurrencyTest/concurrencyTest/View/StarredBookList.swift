//
//  BookDetailed view.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 03/04/24.
//

import SwiftUI

struct StarredBookList: View {
    @ObservedObject var vm: BookListViewModel
    
    var body: some View {
        if vm.starredBook.isEmpty {
            VStack{
                Text("No Starred Book")
            }
        } else {
            List{
                ForEach(vm.starredBook) { book in
                    BookRaw(doc:book)
                }
            }
        }
    }
}


