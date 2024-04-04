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
        List{
            if vm.book.isEmpty{
                VStack{
                    Text("Searching...")
                    ProgressView()
                }
            }else{
                ForEach(vm.book) { book in
                    BookRaw(doc:book)
                    Button(action: {
                        vm.starredBook.append(book)
                        print(vm.starredBook.first?.title ?? "Empty")
                    }, label: {
                        Text("Set as fovourite")
                    })
                }
            }
            
        }
        
    }
}

#Preview {
    BookList(vm: BookListViewModel())
}
