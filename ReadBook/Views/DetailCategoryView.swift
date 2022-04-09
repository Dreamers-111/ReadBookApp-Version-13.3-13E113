//
//  DetailCategoryView.swift
//  ReadBookApp
//
//  Created by Phan Tam Nhu on 31/03/2022.
//

import SwiftUI

class detailCategoryBook {
    private var imageName: String
    var image: Image{
        Image(imageName)
    }
    var title: String
    var author: String
    var totalChapter: Int
    var genre: String
    
    init(imageName: String, title: String, author: String,totalChapter: Int, genre: String) {
        self.imageName = imageName
        self.title = title
        self.author = author
        self.totalChapter = totalChapter
        self.genre = genre
    }
}

struct DetailCategoryView: View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
    let book: [detailCategoryBook]
    let category: String
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            detailList(books: book)
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView (
                                        action:{
                                            presentationMode.wrappedValue.dismiss()
                                        })
                                    )
                .navigationBarTitle("\(category)", displayMode: .inline)
        }
    }
}

struct itemList :  View {

    let image: Image
    let title: String
    let author: String
    let totalChapter: Int
    let genre: String
    
    var body: some View {
        HStack(spacing: 12) {
            image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .frame(width: 123, height: 191)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                VStack(alignment: .leading, spacing: 5) {
                    Text("Tác giả: \(author)")
                        
                    Text("Tổng số chương: \(totalChapter)")
                        
                    Text("Thể loại: \(genre)")
                    
                    Spacer()
                }
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                .font(.system(size: 16))
            }
        }
    }
}

struct detailList : View {
    let books: [detailCategoryBook]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(0..<books.count) { index in
                    itemList(image: books[index].image,
                         title: books[index].title,
                         author: books[index].author,
                         totalChapter: books[index].totalChapter,
                         genre: books[index].genre)
                }
            }
        }
    }
}

struct DetailCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        DetailCategoryView(book: [], category: "")
    }
}
