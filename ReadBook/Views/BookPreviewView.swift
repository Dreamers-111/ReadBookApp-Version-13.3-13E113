//
//  BoookPreviewView.swift
//  ReadBookApp
//
//  Created by Hùng on 23/03/2022.
//
import SwiftUI

struct BookPreviewView: View {
    var bookId:String
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @StateObject private var vm = BookPreviewViewModel()
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false){
                VStack(alignment: .leading, spacing : 5){
                    bookInfoView(image: vm.books[0].image, title: vm.books[0].title, author: vm.books[0].author)
                        .padding(.horizontal)
                    
                    aboutAuthorBook_TextView(aboutAuthor: vm.books[0].aboutAuthor)
                        .padding(.horizontal)
                    
                    descriptionBook_TextView(description: vm.books[0].description)
                        .padding(.horizontal)
                    
                    bookChapter_ForeachView(title: vm.books[0].title, chapters: vm.books[0].chapters)
                        .padding(.horizontal)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    Spacer()
                    
                }
            }
            
            readAndBookmark_ButtonView(title: vm.books[0].title,
                                       name: vm.books[0].chapters[0].name,
                                       content: vm.books[0].chapters[0].content)
            .frame(maxHeight: .infinity,alignment: .bottom)
            .padding(.bottom)
            .padding(.bottom)
            .padding()
            
            bottomNavBar()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                CustomBackButtonView(
                                    action:{
                                        presentationMode.wrappedValue.dismiss()
                                    }))
        .navigationBarTitle(vm.books[0].title + " - " + vm.books[0].author, displayMode: .inline)
        .onAppear {
            vm.fetchBookById(bookId: bookId)
        }
        .onDisappear {
            vm.removeAllLoadingListeners()
        }
    }
}


struct bookInfoView: View {
    var image:Image
    var title:String
    var author:String
    var body: some View {
        VStack(alignment: .center){
            
            image
                .resizable()
                .frame(width: 191, height: 297)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(title)
                .font(.system(size: 18))
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Text(author)
                .font(.system(size: 16))
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }
        .frame(maxWidth:.infinity, alignment: .center)
        .padding(.bottom)
        
    }
}

struct aboutAuthorBook_TextView: View {
    var aboutAuthor:String
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Về tác giả:")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color.black)
            
            Text(aboutAuthor)
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }
    }
}

struct descriptionBook_TextView: View {
    var description:String
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Mô tả:")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color.black)
            
            Text(description)
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }
    }
}

struct bookChapter_ForeachView: View {
    var title:String
    var chapters:[BookChapter]
    @State private var action: Int? = 0
    var body: some View {
        
        VStack(alignment: .leading){
            
            Section(header:
                        
                        Text("Số chương:")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color.black)
                    
            ) {
                
                ForEach(chapters.indices, id: \.self) {
                    index in
                    NavigationLink(destination:
                                    BookChapterView(
                                        title: title,
                                        name: chapters[index].name,
                                        content: chapters[index].content)
                    )
                    {
                        VStack {
                            Text(chapters[index].name)
                                .font(.system(size: 16))
                                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                                .frame(maxWidth: .infinity, maxHeight: 10, alignment: .leading)
                            Divider()
                                .frame(height: 0.7)
                                .padding(.horizontal, 30)
                                .background(Color.black)
                                .opacity(0.5)
                        }
                    }
                }
            }
        }
        
    }
}

struct readAndBookmark_ButtonView: View {
    var title:String
    var name:String
    var content:String
    @State private var selection: Int? = 0
    var body: some View {
        HStack {
            
            NavigationLink(tag: 1, selection: $selection) {
                BookChapterView(
                    title: title,
                    name: name,
                    content: content)
            } label: {
                Button {
                    self.selection = 1
                } label: {
                    Text("Đọc sách")
                        .fontWeight(.black)
                        .foregroundColor(.white)
                }
                .frame(width: 168.0, height: 57.0)
                .background(Color(red: 0.13, green: 0.72, blue: 0.57))
                .cornerRadius(10)
                .animation(.default)
            }
            
            Spacer()
            
            Button{
                print("Bookmarrk")
                
            } label: {
                
                Text("Bookmak")
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
            }
            .frame(width: 168.0, height: 57.0)
//          .background(true ? Color(#colorLiteral(red: 0.78, green: 0.56, blue: 0.56, alpha: 1)) : Color(#colorLiteral(red: 0.83, green: 0.33, blue: 0.33, alpha: 1)))
            .background(Color(red: 0.78, green: 0.56, blue: 0.56).opacity(1))
            .cornerRadius(10)
            .animation(.default)
        }
    }
}


struct BookPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BookPreviewView(bookId: "DSsSYmqhPHrwouFh9x5j")
    }
}


