//
//  CategoryView.swift
//  ReadBookApp
//
//  Created by Phan Tam Nhu on 25/03/2022.
//

import SwiftUI

struct CategoryView: View {
    
    @State private var selectedBottomNavBarItemIndex = 1
    
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    
    var body: some View {
    
        VStack(spacing: 15) {
            
            Spacer()
            
            Text("CÁC THỂ LOẠI SÁCH HAY NHẤT HIỆN NAY")
                .fontWeight(.bold)
                .font(.system(size: 16.5))
                .foregroundColor(Color(#colorLiteral(red: 0.13, green: 0.72, blue: 0.57, alpha: 1)))

            VStack(spacing: 15) {
                HStack {
                    khoahocBtn()
                    tamlyBtn()
                }
                HStack {
                    vanhocBtn()
                    langmanBtn()
                }
                HStack {
                    tieuthuyetBtn()
                    nuocngoaiBtn()
                }
            }
            
            Spacer()
            
            bottomNavBar()
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView (
                                action:{
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
        .navigationBarTitle("THỂ LOẠI", displayMode: .inline)
    }
}

struct ButtonCategory: View {
    let name: String
    let quantity: Int
    let colorBackground: Color
    let colorFirtItem: Color
    let colorTextName: Color
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 4)
                .fill(colorBackground)
                .frame(width: 160, height: 70)
            
            HStack(spacing: 15){
                RoundedRectangle(cornerRadius: 4)
                    .fill(colorFirtItem)
                    .frame(width: 10, height: 33)
                
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.system(size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(colorTextName)
                    Text("\(quantity) sách")
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                }
            }
        }
    }
}

struct khoahocBtn: View {
    
    let book = [detailCategoryBook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Khoa học"),
                detailCategoryBook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Khoa học"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Khoa học")
                ]
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            DetailCategoryView(book: book, category: "Khoa học")
        }
        label: {
            Button {
                self.action = 1
            } label: {
                ButtonCategory(
                    name: "Khoa học",
                    quantity: 15,
                    colorBackground: Color(#colorLiteral(red: 1, green: 0.9607843160629272, blue: 0.8823529481887817, alpha: 1)),
                    colorFirtItem: Color(#colorLiteral(red: 0.7137255072593689, green: 0.4941176474094391, blue: 0.11764705926179886, alpha: 1)),
                    colorTextName: Color(#colorLiteral(red: 0.71, green: 0.49, blue: 0.12, alpha: 1))
                )
            }
        }
    }
}

struct tamlyBtn: View {
    
    let book = [detailCategoryBook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Tâm lý"),
                detailCategoryBook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Tâm lý"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Tâm lý")
                ]
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            DetailCategoryView(book: book, category: "Tâm lý")
        } label: {
             Button {
                 self.action = 1
             } label: {
                 ButtonCategory(
                     name: "Tâm lý",
                     quantity: 10,
                     colorBackground: Color(#colorLiteral(red: 0.9215686321258545, green: 0.9490196108818054, blue: 0.9725490212440491, alpha: 1)),
                     colorFirtItem: Color(#colorLiteral(red: 0.27843138575553894, green: 0.40784314274787903, blue: 0.5882353186607361, alpha: 1)),
                     colorTextName: Color(#colorLiteral(red: 0.28, green: 0.41, blue: 0.59, alpha: 1))
                 )
             }
        }
    }
}

struct vanhocBtn: View {
    
    let book = [detailCategoryBook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Văn học"),
                detailCategoryBook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Văn học"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Văn học")
                ]
    
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            DetailCategoryView(book: book, category: "Văn học")
        } label: {
             Button {
                 self.action = 1
             } label: {
                 ButtonCategory(
                     name: "Văn học",
                     quantity: 2,
                     colorBackground: Color(#colorLiteral(red: 0.9215686321258545, green: 0.9490196108818054, blue: 0.9725490212440491, alpha: 1)),
                     colorFirtItem: Color(#colorLiteral(red: 0.27843138575553894, green: 0.40784314274787903, blue: 0.5882353186607361, alpha: 1)),
                     colorTextName: Color(#colorLiteral(red: 0.28, green: 0.41, blue: 0.59, alpha: 1))
                 )
             }
        }
    }
}

struct langmanBtn: View {
    
    let book = [detailCategoryBook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Lãng mạn"),
                detailCategoryBook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Lãng mạn"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Lãng mạn")
                ]
    
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            DetailCategoryView(book: book, category: "Lãng mạn")
        } label: {
            Button {
                self.action = 1
            } label: {
                ButtonCategory(
                    name: "Lãng mạn",
                    quantity: 11,
                    colorBackground: Color(#colorLiteral(red: 0.9686274528503418, green: 0.9450980424880981, blue: 0.9921568632125854, alpha: 1)),
                    colorFirtItem: Color(#colorLiteral(red: 0.48235294222831726, green: 0.250980406999588, blue: 0.501960813999176, alpha: 1)),
                    colorTextName: Color(#colorLiteral(red: 0.48, green: 0.25, blue: 0.5, alpha: 1))
                )
            }
        }
    }
}

struct tieuthuyetBtn: View {
    
    let book = [detailCategoryBook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Tiểu thuyết"),
                detailCategoryBook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Tiểu thuyết"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Tiểu thuyết")
                ]
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            DetailCategoryView(book: book, category: "Tiểu thuyết")
        } label: {
            Button {
                self.action = 1
            } label: {
                ButtonCategory(
                    name: "Tiểu thuyết",
                    quantity: 10,
                    colorBackground: Color(#colorLiteral(red: 1, green: 0.9450980424880981, blue: 0.9450980424880981, alpha: 1)),
                    colorFirtItem: Color(#colorLiteral(red: 0.7098039388656616, green: 0.3176470696926117, blue: 0.3686274588108063, alpha: 1)),
                    colorTextName: Color(#colorLiteral(red: 0.71, green: 0.32, blue: 0.37, alpha: 1))
                )
            }
        }
    }
}

struct nuocngoaiBtn: View {
    
    let book = [detailCategoryBook(imageName: "nhasachmienphi-juliet", title: "Juliet", author: "Anne Fortier",totalChapter: 12, genre: "Tiểu thuyết"),
                detailCategoryBook(imageName: "nhasachmienphi-mot-ngay-cho-mot-doi", title: "Một ngày cho đời", author: "Christin Antoni", totalChapter: 15, genre: "Nước ngoài"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Nước ngoài"),
                detailCategoryBook(imageName: "nhasachmienphi-bay-nam-sau", title: "Bảy năm sáu", author: "Guillaume Musso", totalChapter: 10, genre: "Nước ngoài")
                ]
    
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            DetailCategoryView(book: book, category: "Nước ngoài")
        } label: {
            Button {
                self.action = 1
            } label: {
                ButtonCategory(
                    name: "Nước ngoài",
                    quantity: 10,
                    colorBackground: Color(#colorLiteral(red: 0.9215686321258545, green: 0.9490196108818054, blue: 0.9725490212440491, alpha: 1)),
                    colorFirtItem: Color(#colorLiteral(red: 0.27843138575553894, green: 0.40784314274787903, blue: 0.5882353186607361, alpha: 1)),
                    colorTextName: Color(#colorLiteral(red: 0.28, green: 0.41, blue: 0.59, alpha: 1))
                )
            }
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView()
    }
}
