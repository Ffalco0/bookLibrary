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
            ForEach(vm.book) { book in
            
                BookRaw(doc:book)
            }
        }
    }
}

#Preview {
    BookList(vm: BookListViewModel())
}
