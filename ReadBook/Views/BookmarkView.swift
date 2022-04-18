//
//  BookmarkView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/10/22.
//

import SwiftUI

struct BookmarkView : View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @EnvironmentObject var userVm:SignInViewModel
    @StateObject private var vm = HomeViewModel()
    @StateObject private var vmBm = BookmarkViewModel()
    @State private var selectedBottomNavBarItemIndex = 3
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false){
                
                listBookmark(books: vmBm.booksbookmark)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            bottomNavBar(selectedBottomNavBarItemIndex: $selectedBottomNavBarItemIndex)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView (
                                action:{
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
        .navigationBarTitle("BOOKMARK", displayMode: .inline)
        .onAppear{
            vm.fetchBooks()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.002) {
                vmBm.fetchBooksBookmark(books: vm.books2, userBookmark: userVm.user.bookmark)
            }
           
        }
    }
}

struct listItems :  View {

    let image: Image
    let title: String
    let author: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 100, height: 145)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 18))
                    .fontWeight(.bold)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Tác giả: \(author)")
                    
                    Spacer()
                }
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                .font(.system(size: 14))
            }
            
            Image(systemName: "bookmark")
                .resizable()
                .frame(width: 22, height: 40,alignment: .top)
                .foregroundColor(Color(red: 212/255, green: 85/255, blue: 85/255))
                .padding(.leading)
                .padding(.leading)
            
        }
    }
}

struct listBookmark : View {
    let books: [Book]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(books.indices, id: \.self) { index in
                    listItems(image: books[index].image,
                         title: books[index].title,
                         author: books[index].author)
                }
            }
        }
    }
}

struct BookmarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookmarkView()
    }
}
