//
//  MenuView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/14/22.
//

import SwiftUI

class myMenu {
    private var icon: String
    
    var iconName: Image {
        Image(icon)
    }
    
    var name: String
    
    init(icon:String,name:String) {
        self.icon = icon
        self.name = name
    }
}

struct MenuView: View {
    let item1 = [myMenu(icon: "home", name: "Trang chủ"),
                 myMenu(icon: "options-lines", name: "Thể loại"),
                 myMenu(icon: "bookmark", name: "Bookmark"),
                 myMenu(icon: "settings", name: "Cài đặt")]
    
    let item2 = [myMenu(icon: "browser", name: "Truy cập website"),
                 myMenu(icon: "star", name: "Đánh giá 5 sao"),
                 myMenu(icon: "email", name: "Gửi phản hồi"),
                 myMenu(icon: "settings", name: "Chính sách bảo mật")]
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomLeading){
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.12941177189350128, green: 0.7215686440467834, blue: 0.572549045085907, alpha: 1)))
                    .frame(height: 160)
                Image_TitleMenu()
            }.zIndex(1)
           
            VStack(alignment: .leading) {
                
                    listItemMenu(item: item1)
                        .padding(.horizontal)
                        .padding(.top,40)
        
                    Rectangle()
                        .frame(height: 0.5)
                        .padding(.horizontal,30)
                        
                    listItemMenu(item: item2)
                    .padding(.horizontal)
                
                Spacer()
                
            }
            .background(Color(.white))
            .frame(height: 700)
            .offset(x: 0 , y: -24)
            .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
        }.edgesIgnoringSafeArea(.all)
            
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct Image_TitleMenu: View {
    var body: some View {
        VStack{
            HStack(spacing: 10) {
                Image(uiImage: #imageLiteral(resourceName: "people"))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .zIndex(1)
                Text("DREAMERS")
                        .font(.system(size: 22)).bold()
                        .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }.offset(x: 20, y: 25)
        }
    }
}

struct ButtonMenu: View {
    let image:Image
    let name:String
    var body: some View {
        HStack{
            Button(action: {
                
            }, label: {
                image
                    .resizable()
                    .frame(width: 25, height: 25)
                Text(name)
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .tracking(1)
                }
            )
        }.padding()
    }
}

struct listItemMenu: View {
    let item: [myMenu]
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<item.count) { index in
                ButtonMenu(image: item[index].iconName, name: item[index].name)
            }
        }
    }
}
