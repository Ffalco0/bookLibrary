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
        NavigationView{
            if vm.starredBook.isEmpty {
                VStack{
                    Text("No Starred Book")
                }
            } else {
                List{
                    ForEach(vm.starredBook.indices, id: \.self) { index in
                        HStack {
                            BookRaw(doc: vm.starredBook[index])
                            Spacer()
                            Button(action: {
                                vm.removeStarredBook(at: index)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
        }.navigationTitle("Starred")
    }
}


