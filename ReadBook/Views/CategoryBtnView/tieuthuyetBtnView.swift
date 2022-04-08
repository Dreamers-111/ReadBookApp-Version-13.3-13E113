//
//  tieuthuyetBtnView.swift
//  ReadBookApp
//
//  Created by Phan Tam Nhu on 26/03/2022.
//

import SwiftUI

class TieuThuyetbook {
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

struct tieuthuyetBtnView: View {
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
    let book = [TieuThuyetbook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Tiểu thuyết"),
                TieuThuyetbook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Tiểu thuyết"),
                TieuThuyetbook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Tiểu thuyết")
                ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
            tieuthuyetList(books: book)
                .padding()
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButtonView (
                                        action:{
                                            presentationMode.wrappedValue.dismiss()
                                        })
                                    )
                .navigationBarTitle("Tiểu thuyết", displayMode: .inline)
        }
    }
}

struct item: View {
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

struct tieuthuyetList: View {
    let books: [TieuThuyetbook]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                ForEach(0..<books.count) { index in
                    item(image: books[index].image,
                         title: books[index].title,
                         author: books[index].author,
                         totalChapter: books[index].totalChapter,
                         genre: books[index].genre)
                }
            }
        }
    }
}

struct tieuthuyetBtnView_Previews: PreviewProvider {
    static var previews: some View {
        tieuthuyetBtnView()
    }
}
