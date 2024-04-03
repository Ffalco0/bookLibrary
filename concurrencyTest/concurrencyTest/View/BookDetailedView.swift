//
//  BookDetailed view.swift
//  concurrencyTest
//
//  Created by Fabio Falco on 03/04/24.
//

import SwiftUI

struct BookDetailedView: View {
    @ObservedObject var vm: BookListViewModel
    var body: some View {
        Text("hello")
    }
}

#Preview {
    BookDetailedView(vm: BookListViewModel())
}
