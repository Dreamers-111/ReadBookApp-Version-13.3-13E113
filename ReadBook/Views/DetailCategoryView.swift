//
//  DetailCategoryView.swift
//  ReadBookApp
//
//  Created by Phan Tam Nhu on 31/03/2022.
//

import SwiftUI

struct DetailCategoryView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State private var selection:Int?
    @StateObject private var vm = HomeViewModel()
    let category: String
    let categoryId: String
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            detailList(selection: $selection, books: vm.books1)
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView (
                                        action:{
                                            presentationMode.wrappedValue.dismiss()
                                        })
                                    )
                .navigationBarTitle("\(category)", displayMode: .inline)
                .onAppear {
                    vm.fetchBooksByCategory(categoryId: categoryId)
                }
                .onDisappear {
                    vm.removeAllListeners()
                }
        }
    }
}

struct itemList :  View {
    var id:String
    let image: Image
    let title: String
    let author: String
    var tag = Int.random(in: 1...7) * Int.random(in: 1...7) * Int.random(in: 1...7) * Int.random(in: 1...7) * Int.random(in: 1...7)
    @Binding var selection:Int?
    let totalChapters: Int
    
    var body: some View {
        NavigationLink(tag: tag, selection: $selection) {
            BookPreviewView(bookId: id)
        } label: {
            Button {
                selection = tag
            } label: {
                HStack(spacing: 12) {
                    image
                        .resizable()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(width: 123, height: 191)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                            .font(.system(size: 17))
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Tác giả: \(author)")
                            Text("Tổng số chương: \(totalChapters)")
                            Spacer()
                        }
                        .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                        .font(.system(size: 16))
                    }
                }
            }
        }
    }
}

struct detailList : View {
    @Binding var selection:Int?
    let books: [Book]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(books) { book in
                    itemList(id: book.id,
                             image: book.image,
                             title: book.title,
                             author: book.author,
                             selection: $selection,
                             totalChapters: book.totalChapters)
                }
            }
        }
    }
}

struct DetailCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategoryView(category: "", categoryId: "")
    }
}
