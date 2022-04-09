//
//  BookmarkView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/10/22.
//

import SwiftUI

class detailBookmark {
    private var imageName: String
    var image: Image{
        Image(imageName)
    }
    var title: String
    var author: String
    var totalChapter: Int
    
    init(title: String, author: String, imageName: String, totalChapter: Int) {
        self.title = title
        self.author = author
        self.imageName = imageName
        self.totalChapter = totalChapter
    }
}

struct BookmarkView : View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
    let books =
    [detailBookmark(title: "20 giờ đầu tiên", author: "Josh Kaufman", imageName: "nhasachmienphi-20-gio-dau-tien", totalChapter: 12),
    detailBookmark(title: "Một ngày cho đời", author: "Christin Antoni", imageName: "nhasachmienphi-mot-ngay-cho-mot-doi",totalChapter: 13)]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            listBookmark(books: books)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView (
                                action:{
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
        .navigationBarTitle("BOOKMARK", displayMode: .inline)
    }
}

struct listItems :  View {

    let image: Image
    let title: String
    let author: String
    let totalChapter: Int
    
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
                        
                    Text("Tổng số chương: \(totalChapter)")
                    
                    Spacer()
                }
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                .font(.system(size: 14))
            }
            
            Image(systemName: "bookmark")
                .resizable()
                .frame(width: 22, height: 40,alignment: .top)
                .padding(.leading)
                .padding(.leading)
            
        }
    }
}

struct listBookmark : View {
    let books: [detailBookmark]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(0..<books.count) { index in
                    listItems(image: books[index].image,
                         title: books[index].title,
                         author: books[index].author,
                         totalChapter: books[index].totalChapter)
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
