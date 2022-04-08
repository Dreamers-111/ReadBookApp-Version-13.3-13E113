//
//  BoookPreviewView.swift
//  ReadBookApp
//
//  Created by Hùng on 23/03/2022.
//
import SwiftUI

struct myChapter {
    var name:String
    var content:String
}

class myBook1 {
    var title:String
    var author:String
    var about_author:String
    var description:String
    var isBookmark:Bool
    var chapter: [myChapter]
    private var imageName:String
    var image:Image{
        Image(imageName)
    }
    init(title:String,author:String,imageName:String, about_author:String,description:String, isBookmark:Bool,chapter: [myChapter]){
        self.title = title
        self.author = author
        self.imageName = imageName
        self.about_author = about_author
        self.description = description
        self.isBookmark = isBookmark
        self.chapter = chapter
    }
}

    
struct BookPriviewView: View {
    
    @State private var selectedBottomNavBarItemIndex = 0
    
    let book = myBook1(title: "Juliet", author: "Anne Fortier", imageName: "nhasachmienphi-juliet",about_author: "Anne Fortier (sinh năm 1971) là nhà văn người Đan Mạch gốc Canada, sống ở Mỹ và Canada từ năm 2002.",description: "Với ai từng đam mê những hình ảnh và ngôn từ tuyệt đẹp, hay nuối tiếc với cái kết chưa có hậu về mối tình kinh điển Romeo và Juliet của Shakespeare, thì khi đọc cuốn tiểu thuyết Juliet này, độc giả sẽ không chỉ được hòa mình vào không khí ngất ngây của mối thiên tình sử ấy, mà còn được nghẹt thở cùng những cuộc phiêu lưu, rượt đuổi mạo hiểm, và hơn hết, là được thỏa lòng với hồi kết có hậu: đám cưới hạnh phúc tất yếu giữa chàng Romeo lịch lãm, can trường, và nàng Juliet thông minh, mạnh mẽ.", isBookmark: false, chapter:
        [myChapter(
            name: "Lời mở đầu",
            content: "Cảm ơn các bạn"),
         myChapter(
            name: "Chương 1",
            content:
            "Tôi phải dành thời gian để hình dung nên bắt đầu từ đâu. Bạn có thể cãi rằng câu chuyện của tôi bắt đầu từ hơn sáu trăm năm trước, với vụ cưới đường ở thành phố Tuscany thời Trung cổ. Hoặc gần hơn, là cuộc vũ hội và nụ hôn ở lâu đài Salimbeni, nơi cha mẹ tôi gặp nhau lần đầu tiên. Nhưng tôi sẽ không bao giờ biết gì về những chuyện này, nếu không có một sự kiện làm thay đổi cả cuộc đời tôi trong chớp mắt, và buộc tôi phải đến Italy tìm về quá khứ. Mọi chuyện bắt đầu kể từ khi bà bác Rose của tôi qua đời.\nUmberto mất ba ngày trời mới tìm ra tôi để báo tin buồn. Xét về niềm đam mê nghệ thuật đang lụi dần của mình, tôi kinh ngạc khi thấy ông tìm được tôi. Nhưng Umberto luôn có một khả năng phi thường là đọc được ý nghĩ và đoán trước được hành động của tôi; ngoài ra, ở Virginiea không có nhiều trại hè Shakespeare.Tôi không biết ông đã đứng tận cuối\nTôi phải dành thời gian để hình dung nên bắt đầu từ đâu. Bạn có thể cãi rằng câu chuyện của tôi bắt đầu từ hơn sáu trăm năm trước, với vụ cưới đường ở thành phố Tuscany thời Trung cổ. Hoặc gần hơn, là cuộc vũ hội và nụ hôn ở lâu đài Salimbeni, nơi cha mẹ tôi gặp nhau lần đầu tiên. Nhưng tôi sẽ không bao giờ biết gì về những chuyện này, nếu không có một sự kiện làm thay đổi cả cuộc đời tôi trong chớp mắt, và buộc tôi phải đến Italy tìm về quá khứ. Mọi chuyện bắt đầu kể từ khi bà bác Rose của tôi qua đời.\nUmberto mất ba ngày trời mới tìm ra tôi để báo tin buồn. Xét về niềm đam mê nghệ thuật đang lụi dần của mình, tôi kinh ngạc khi thấy ông tìm được tôi. Nhưng Umberto luôn có một khả năng phi thường là đọc được ý nghĩ và đoán trước được hành động của tôi; ngoài ra, ở Virginiea không có nhiều trại hè Shakespeare.Tôi không biết ông đã đứng tận cuối"),
         myChapter(
            name: "Chương 2",
            content:"Hôm nay trời mưa"),
         myChapter(
            name: "Chương 3",
            content:"Hôm nay trời nắng"),
         myChapter(
            name: "Chương 4",
            content:"Hôm nay trời mây")])

    var body: some View {
        
        NavigationView {
            ZStack {
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing : 5){
                        back_ButtonView()
                            .padding(.horizontal)
                        
                        bookInfoView(book: book)
                            .padding(.horizontal)
                        
                        aboutAuthorBook_TextView(book: book)
                            .padding(.horizontal)
                        
                        descriptionBook_TextView(book: book)
                            .padding(.horizontal)
            
                        bookChapter_ForeachView(book: book)
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
            
                VStack() {
                    
                    ZStack{
                        
                        readAndBookmark_ButtonView(book: book)
                            .frame(maxHeight: .infinity,alignment: .bottom)
                            .padding(.bottom)
                            .padding(.bottom)
                            .padding()

                        bottomNavBar(selectedBottomNavBarItemIndex: $selectedBottomNavBarItemIndex)
                            
                    }
                }

            }
        }
    }
}

struct back_ButtonView: View {
    var body: some View {
        HStack {
            
            Button {
                print("Back to Book list")
            } label: {
                Image("ArrowLeftBack")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Spacer()
            
        }
    }
}

struct bookInfoView: View {
    let book : myBook1
    var body: some View {
        VStack(alignment: .center){
            
            book.image
                .resizable()
                .frame(width: 191, height: 297)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            Text(book.title)
                .font(.system(size: 18))
                .fontWeight(.black)
                .foregroundColor(.black)
            
            Text(book.author)
                .font(.system(size: 16))
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }
        .frame(maxWidth:.infinity, alignment: .center)
        .padding(.bottom)
        
    }
}

struct aboutAuthorBook_TextView: View {
    let book: myBook1
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Về tác giả:")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color.black)
            
            Text(book.about_author)
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }
    }
}

struct descriptionBook_TextView: View {
    let book: myBook1
    var body: some View {
        VStack(alignment: .leading){
            
            Text("Mô tả:")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color.black)
            
            Text(book.description)
                .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }
    }
}

struct bookChapter_ForeachView: View {
    let book: myBook1
    @State private var action: Int? = 0
    var body: some View {
        
        VStack(alignment: .leading){
            
            Section(header:
                        
                Text("Số chương:")
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(Color.black)
                    
            ) {
                
                ForEach(book.chapter, id: \.name) {
                    chap in
                    NavigationLink(destination:
                                        BookChapterView(
                                            title: book.title,
                                            name: chap.name,
                                            content: chap.content
                                        )
                                   )
                    {
                        VStack {
                            Text(chap.name)
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
                    .navigationBarHidden(true)
                    
                }
            }
        }

    }
}



struct readAndBookmark_ButtonView: View {
    var book: myBook1
    @State private var action: Int? = 0
    var body: some View {
        HStack {
            
            NavigationLink(tag: 1, selection: $action) {
                BookChapterView(
                    title: book.title,
                    name: book.chapter[0].name,
                    content: book.chapter[0].content
                )
            } label: {
                Button {
                    self.action = 1
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
                
                book.isBookmark = !book.isBookmark
                print("Add to bookmark")
                print(book.isBookmark)
                
            } label: {
                
                Text("Bookmak")
                    .fontWeight(.black)
                    .foregroundColor(.white)
                
            }
            .frame(width: 168.0, height: 57.0)
            .background(book.isBookmark ? Color(#colorLiteral(red: 0.78, green: 0.56, blue: 0.56, alpha: 1)) : Color(#colorLiteral(red: 0.83, green: 0.33, blue: 0.33, alpha: 1)))
            .cornerRadius(10)
            .animation(.default)
        }
    }
}


struct BookPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        BookPriviewView()
    }
}


