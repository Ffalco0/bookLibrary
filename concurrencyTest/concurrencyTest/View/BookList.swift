//
//  BookList.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 02/04/24.
//

import SwiftUI

struct BookList: View {
    @ObservedObject var vm: BookListViewModel
    
    
    var body: some View {
        
        if vm.book.isEmpty{
            ProgressView()
        }else{
            List{
                ForEach(vm.book) { book in
                    HStack{
                        BookRaw(doc:book)
                        Button(action: {
                            if !vm.isPresented(book: book){
                                vm.starredBook.append(book)
                            }
                        }, label: {
                            Image(systemName: vm.isPresented(book: book) ? "star.fill" : "star")
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    BookList(vm: BookListViewModel())
}
