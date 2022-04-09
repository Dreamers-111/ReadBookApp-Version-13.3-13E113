//
//  HomeView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/7/22.
//

import SwiftUI

class myBook{
    var title:String
    var author:String
    private var imageName:String
    var image:Image{
        Image(imageName)
    }
    init(title:String,author:String,imageName:String){
        self.title = title
        self.author = author
        self.imageName = imageName
    }
}

struct HomeView: View {
    @StateObject private var vm = HomeViewModel()
    @State private var username: String = "Dreamers"
    
    @State private var searchText = ""
    
    let categories = ["Tiểu thuyết","Khoa học","Lãng mạn","Tâm lý","Giáo dục"]
    
    let books1 = [myBook(title: "20 giờ đầu tiên", author: "Josh Kaufman", imageName: "nhasachmienphi-20-gio-dau-tien"),
                  myBook(title: "Một ngày cho đời", author: "Christin Antoni", imageName: "nhasachmienphi-mot-ngay-cho-mot-doi"),
                  myBook(title: "Vượn trần trụi", author: "Desmond Morris", imageName: "nhasachmienphi-vuon-tran-trui"),
                  myBook(title: "Juliet", author: "Anne Fortier", imageName: "nhasachmienphi-juliet")]
    let books2 = [myBook(title: "Bảy năm sáu", author: "Guillaume Musso", imageName: "nhasachmienphi-bay-nam-sau"),
                  myBook(title: "Sói thảo nguyên", author: "Hẻmann hesse", imageName: "nhasachmienphi-soi-thao-nguyen"),
                  myBook(title: "20 giờ đầu tiên", author: "Josh Kaufman", imageName: "nhasachmienphi-20-gio-dau-tien"),
                  myBook(title: "Juliet", author: "Anne Fortier", imageName: "nhasachmienphi-juliet")]
    
    @State private var selectedCategoryIndex = 0
    
    @State private var selectedBottomNavBarItemIndex = 0
    
    @State var size = UIScreen.main.bounds.width / 1.2
    
    var body: some View {
        
        ZStack {
            
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading, spacing:0) {
                    
                    welcomeText(username: $username)
                        .padding(.horizontal)
                        .padding(.vertical)
                    
                    searchBar(searchText: $searchText)
                        .padding(.horizontal)
                    
                    theLoaiBtn_bookMarkBtn()
                        .padding()
                    
                    categoryBar(categories: vm.categories)
                    .padding(.leading)
                    
                    listBook(books: books1)
                        .padding(.vertical).padding(.leading)
                    
                    Text("Sách mới")
                        .font(.system(size: 24))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.11))
                        .padding(.top)
                        .padding(.horizontal)
                    
                    listBook(books: books2)
                        .padding(.leading)
                        .padding(.vertical)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                }
            }
            .padding(.top)
            .padding(.top)
            
            bottomNavBar()
            
            MenuTop(size: self.$size)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal)
            
            HStack {
                MenuView(size: $size)
                    .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
                    .edgesIgnoringSafeArea(.all)
                Spacer()
            }
            .animation(.spring())

        }
        .onAppear {
            self.vm.fectchBookCategories()
            
        }
        .navigationBarHidden(true)

    }
}

struct MenuTop: View {
    @Binding var size: CGFloat
    var body: some View {
        HStack {
            Button(action: {
                self.size = 5
            }, label: {
                Image("align-left")
                    .resizable()
                    .frame(width: 40, height: 40)
            })
            
            Spacer()
            
            Button(action: {}, label: {
                Image("people")
                    .resizable()
                    .frame(width: 40, height: 40)
            })
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct welcomeText: View {
    
    @Binding var username:String
    
    var body: some View {
        Text("Chào mừng quay trở lại,")
            .font(.custom("Poppins Medium", size: 16))
            .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
        + Text(" \(username).")
            .font(.custom("Poppins Medium", size: 16))
            .foregroundColor(Color(red: 0.501960814, green: 0.501960814, blue: 0.501960814))
    }
}

struct searchBar: View {
    
    @Binding var searchText:String
    
    var body: some View {
        HStack(spacing:0){
            HStack{
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 18))
                    .foregroundColor(Color(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238))
                
                TextField("Tìm kiếm...", text: $searchText, onCommit: {
                    print("onCommit")
                })
                .font(.system(size: 16))
                .foregroundColor(.primary)
                
                if searchText.count > 0 {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color(red: 0.12941177189350128, green: 0.7215686440467834, blue: 0.572549045085907))
                }
            }
            .padding()
            .background(Color(red: 0.7686274647712708, green: 0.7686274647712708, blue: 0.7686274647712708).opacity(0.15))
            .cornerRadius(8)
            .animation(.default)
            
            
            if searchText.count > 0 {
                Button  {
                    searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    //Tắt keyboard
                } label: {
                    Text("Cancel")
                }
                .font(.system(size: 18))
                .foregroundColor(Color(red: 0.12941177189350128, green: 0.7215686440467834, blue: 0.572549045085907))
                .background(Color.white)
                .padding(.leading)
                .transition(.move(edge: .trailing)) //Xuất hiện từ bên phải
                .animation(.default)
            }
        }
    }
}

struct theLoaiBtn_bookMarkBtn: View {
    @State var showView = false
    @State private var action: Int? = 0
    var body: some View {
        HStack(spacing:0) {
            NavigationLink(tag: 1, selection: $action) {
                CategoryView()
            } label: {
                 Button {
                     self.action = 1
                 } label: {
                     button(image:Image("photo-1507842217343-583bb7270b66"),
                            colorOverlay: Color(red: 0.6784313917160034, green: 0.8117647171020508, blue: 0.9176470637321472).opacity(0.85),
                            title: "THỂ LOẠI",
                            subtitle: "CHUYÊN MỤC")
                     .padding(.trailing)
                 }
            }
//
            NavigationLink(tag: 2, selection: $action) {
                BookmarkView()
            } label: {
                 Button {
                     self.action = 2
                 } label: {
                     button(image:Image("photo-1617635837145-cf409451c41e"),
                            colorOverlay: Color(red: 0.5843137502670288, green: 0.7803921699523926, blue: 0.7372549176216125).opacity(0.85),
                            title: "BOOKMARK",
                            subtitle: "TRUYỆN CỦA BẠN")
                     .padding(.leading)
                 }
            }
            
        }
    }
}

struct button: View {
    let image:Image
    let colorOverlay:Color
    let title:String
    let subtitle:String
    var body: some View {
        ZStack {
            image
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(colorOverlay)
                )
            ( Text(title)
                .font(.system(size: 22))
                .fontWeight(.heavy)
              + Text("\n# \(subtitle)")
                .font(.system(size: 14))
                .fontWeight(.semibold)
            )
            .lineSpacing(5)
            .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, maxHeight: 90)
    }
}

struct categoryBarItem: View {
    let name:String
    let id:String
    let action:()->Void
    let isSelected:Bool
    var body: some View {
        Button {
            action()
            print(id)
        } label: {
            Text(name)
                .font(.system(size: 16))
                .foregroundColor( isSelected ? Color(red: 0.1, green: 0.1, blue: 0.11)
                                  : Color(red: 0.62, green: 0.62, blue: 0.62))
                .multilineTextAlignment(.center)
                .padding(.trailing)
        }
    }
}

struct categoryBar: View {
    let   categories:[BookCategory]
    @State private var selectedCategoryIndex = 0
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories.indices, id: \.self) { index in
                    categoryBarItem(name: categories[index].name,
                                    id: categories[index].id,
                                    action: {selectedCategoryIndex = index},
                                    isSelected: index == selectedCategoryIndex)
                }
            }
        }
    }
}

struct BookView: View {
    let image:Image
    let title:String
    let author:String
    var body: some View {
        Button(action: {
            
        }, label: {
            VStack(alignment: .center) {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 160, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Text(title)
                    .font(.system(size: 16))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.11))
                    .multilineTextAlignment(.center)
                Text(author)
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
                    .multilineTextAlignment(.center)
            }
            .padding(.trailing)
        })
    }
}

struct listBook: View {
    let books:[myBook]
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack(){
                ForEach(0..<books.count) { index in
                    BookView(image: books[index].image, title: books[index].title, author: books[index].author)
                }
            }
        }
    }
}

struct bottomNavBarItem: View {
    let image:Image
    let isActive:Bool
    let action:()->Void
    var body: some View {
        Button(action: action) {
            image
                .font(.system(size: 24))
                .foregroundColor( isActive ? Color(red: 212/255, green: 85/255, blue: 85/255)
                                  : Color.black.opacity(0.6))
                .frame(maxWidth:.infinity)
        }
    }
}

struct bottomNavBar: View {
    @State private var selectedBottomNavBarItemIndex = 0
    let imageNameArray = ["house","book","bookmark","gearshape"]
    var body: some View {
        HStack{
            ForEach(0..<imageNameArray.count) { i in
                bottomNavBarItem(image: Image(systemName: "\(imageNameArray[i])"),
                                 isActive: i == selectedBottomNavBarItemIndex,
                                 action: {
                    selectedBottomNavBarItemIndex = i
                })
            }
        }
        .padding()
        .padding(.horizontal)
        .padding(.top)
        .background(Color.white)
        .cornerRadius(50)
        .shadow(color: Color.black.opacity(0.3), radius: 3)
        .frame(maxHeight:.infinity,alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
    }
}

// MENU

struct MenuView: View {
    @Binding var size : CGFloat
    var body: some View {
        VStack(alignment: .leading) {
                ZStack{
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.size =  UIScreen.main.bounds.width / 1.2
                        }, label: {
                            Image("close")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding()
                                .zIndex(12)
                        }).foregroundColor(.white)
                    }
                        .zIndex(1)
                        .padding(.bottom)
                        .padding(.bottom)
                    
                    ZStack (alignment: .bottomLeading) {
                        Rectangle()
                            .fill(Color(#colorLiteral(red: 0.12941177189350128, green: 0.7215686440467834, blue: 0.572549045085907, alpha: 1)))
                        .frame(height: 160)
                        
                        Image_TitleMenu()
                    }
                }
                .zIndex(1)
                
                VStack(alignment: .leading) {
                    Spacer()
                    ButtonMenuAbove()
                        .padding(.horizontal)
        
                    Rectangle()
                        .frame(height: 0.5)
                        .padding(.horizontal,30)
                        
                    ButtonMenuBelow()
                        .padding(.horizontal)
                
                    Spacer()
                    Spacer()
                }
                .background(Color(.white))
                .offset(x: 0 , y: 0)
                .foregroundColor(Color(#colorLiteral(red: 0.62,green: 0.62,blue: 0.62,alpha: 1)))

            }
            .frame(width: UIScreen.main.bounds.width / 1.2)
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
            image
                .resizable()
                .frame(width: 25, height: 25)
            Text(name)
                .font(.system(size: 20))
                .fontWeight(.medium)
                .tracking(1)
        }.padding()
    }
}

struct ButtonMenuAbove: View {
    @State private var action: Int? = 0
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(tag: 1, selection: $action) {
                HomeView()
            } label: {
                 Button {
                     self.action = 1
                     print("aloo")
                 } label: {
                     ButtonMenu(image:Image("home"), name: "Trang chủ")
                 }
            }
            
            NavigationLink(tag: 2, selection: $action) {
                CategoryView()
            } label: {
                 Button {
                     self.action = 2
                 } label: {
                     ButtonMenu(image:Image("options-lines"), name: "Thể loại")
                 }
            }
            
            NavigationLink(tag: 3, selection: $action) {
                BookmarkView()
            } label: {
                 Button {
                     self.action = 3
                 } label: {
                     ButtonMenu(image:Image("bookmark"), name: "Bookmark")
                 }
            }
            
            NavigationLink(tag: 4, selection: $action) {
                SettingView()
            } label: {
                 Button {
                     self.action = 4
                 } label: {
                     ButtonMenu(image:Image("settings"), name: "Cài đặt")
                 }
            }
        }
    }
}

struct ButtonMenuBelow: View {
    @State private var action: Int? = 0
    var body: some View{
        VStack(alignment: .leading) {
            NavigationLink(tag: 1, selection: $action) {
                HomeView()
            } label: {
                 Button {
                     self.action = 1
                     print("aloo")
                 } label: {
                     ButtonMenu(image:Image("browser"), name: "Truy cập website")
                 }
            }
            
            NavigationLink(tag: 2, selection: $action) {
                CategoryView()
            } label: {
                 Button {
                     self.action = 2
                 } label: {
                     ButtonMenu(image:Image("star"), name: "Đánh giá 5 sao")
                 }
            }
            
            NavigationLink(tag: 3, selection: $action) {
                HomeView()
            } label: {
                 Button {
                     self.action = 3
                 } label: {
                     ButtonMenu(image:Image("email"), name: "Gửi phản hồi")
                 }
            }
            
            NavigationLink(tag: 4, selection: $action) {
                HomeView()
            } label: {
                 Button {
                     self.action = 4
                 } label: {
                     ButtonMenu(image:Image("settings"), name: "Chính sách bảo mật")
                 }
            }
        }
    }
}





