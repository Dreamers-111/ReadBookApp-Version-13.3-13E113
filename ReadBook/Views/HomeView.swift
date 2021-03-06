//
//  HomeView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/7/22.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedBottomNavBarItemIndex = 1
    @EnvironmentObject var userVm:SignInViewModel
    @StateObject private var vm = HomeViewModel()
    @State private var searchText = ""
    @State var size = UIScreen.main.bounds.width / 1.2
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading, spacing:0) {
                    welcomeText(username: "\(userVm.user.ho) \(userVm.user.ten)")
                        .padding(.horizontal)
                        .padding(.vertical)
                        .padding(.top)
                    
                    searchBar(searchText: $searchText)
                        .padding(.horizontal)
                    
                    theLoaiBtn_bookMarkBtn()
                        .padding()
                    
                    categoryBar(categories: vm.categories) { id in
                        vm.removeAllSearchingListeners()
                        vm.fetchBooksByCategory(categoryId: id)
                    }
                    .padding(.leading)
                    
                    ListBookView(books: vm.books1)
                        .padding(.vertical)
                        .padding(.leading)
                    
                    Text("Sách mới")
                        .font(.system(size: 24))
                        .fontWeight(.heavy)
                        .foregroundColor(Color(red: 0.1, green: 0.1, blue: 0.11))
                        .padding(.top)
                        .padding(.horizontal)
                    
                    ListBookView(books: vm.books2)
                        .padding(.leading)
                        .padding(.vertical)
                        .padding(.bottom)
                        .padding(.bottom)
                        .padding(.bottom)
                }
            }
            .padding(.top)
            .padding(.top)
            
            bottomNavBar(selectedBottomNavBarItemIndex: $selectedBottomNavBarItemIndex)
            
            MenuTop(size: $size)
                .background(Color.white.opacity(0.5))
                .cornerRadius(8)
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
        .navigationBarHidden(true)
        .onAppear {
            vm.fetchBookCategories()
            vm.fetchBooks()
        }
        .onDisappear {
            vm.removeAllListeners()
        }
    }
}

struct MenuTop: View {
    @Binding var size: CGFloat
    @State private var selection: Int? = 0
    
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
            
            NavigationLink(tag: 1, selection: $selection) {
                ProfileView()
            } label: {
                Button(action: {
                    self.selection = 1
                }, label: {
                    Image("people")
                        .resizable()
                        .frame(width: 40, height: 40)
                }).padding(.bottom)
            }
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
    
    var username:String
    
    var body: some View {
        Text("Chào mừng quay trở lại,")
            .font(.custom("Poppins Medium", size: 16))
            .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62))
        + Text(" \(username).")
            .font(.custom("Poppins Medium", size: 16)).bold()
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
    @State private var selection: Int? = 0
    var body: some View {
        HStack(spacing:0) {
            NavigationLink(tag: 5, selection: $selection) {
                CategoryView()
            } label: {
                Button {
                    self.selection = 5
                } label: {
                    button(image:Image("photo-1507842217343-583bb7270b66"),
                           colorOverlay: Color(red: 0.6784313917160034, green: 0.8117647171020508, blue: 0.9176470637321472).opacity(0.85),
                           title: "THỂ LOẠI",
                           subtitle: "CHUYÊN MỤC")
                    .padding(.trailing)
                }
            }
            //
            NavigationLink(tag: 6, selection: $selection) {
                BookmarkView()
            } label: {
                Button {
                    self.selection = 6
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
    var image:Image
    var colorOverlay:Color
    var title:String
    var subtitle:String
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
    var name:String
    var id:String
    var isSelected:Bool
    var action:()->Void
    var body: some View {
        Button {
            action()
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
    var categories:[BookCategory]
    var action:(String)->Void
    @State private var selectedCategoryIndex = 0
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack {
                ForEach(categories.indices, id: \.self) { index in
                    categoryBarItem(name: categories[index].name, id: categories[index].id, isSelected: index == selectedCategoryIndex) {
                        selectedCategoryIndex = index
                        action(categories[index].id)
                    }
                    .onAppear {
                        if index == 0 {
                            action(categories[0].id)
                        }
                    }
                }
            }
        }
    }
}

struct BookView: View {
    var id:String
    var title:String
    var author:String
    var image:Image
    var tag = Int.random(in: 1...7) * Int.random(in: 1...7) * Int.random(in: 1...7) * Int.random(in: 1...7) * Int.random(in: 1...7)
    @Binding var selection:Int?
    var body: some View {
        NavigationLink(tag: tag, selection: $selection) {
            BookPreviewView(bookId: id)
        } label: {
            Button {
                selection = tag
            } label: {
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
            }
        }
        
    }
}

struct ListBookView: View {
    var books:[Book]
    @State var selection:Int?
    var body: some View {
        ScrollView (.horizontal, showsIndicators: false) {
            HStack{
                ForEach(books.indices, id: \.self) { index in
                    BookView(id : books[index].id,
                             title: books[index].title,
                             author: books[index].author,
                             image: books[index].image,
                             selection: $selection)
                }
            }
        }
    }
}

struct bottomNavBar: View {
    @Binding var selectedBottomNavBarItemIndex:Int
    @State var selection:Int?
    var body: some View {
        HStack{
            NavigationLink(tag: 7, selection: $selection) {
                HomeView()
            } label: {
                Button {
                    selection = 7
                    selectedBottomNavBarItemIndex = 1
                } label: {
                    Image(systemName: "house")
                        .font(.system(size: 24))
                        .foregroundColor( 1 == selectedBottomNavBarItemIndex ? Color(red: 212/255, green: 85/255, blue: 85/255)
                                          : Color.black.opacity(0.6))
                        .frame(maxWidth:.infinity)
                }
            }

            NavigationLink(tag: 8, selection: $selection) {
                CategoryView()
            } label: {
                Button {
                    selection = 8
                    selectedBottomNavBarItemIndex = 2
                } label: {
                    Image(systemName: "book")
                        .font(.system(size: 24))
                        .foregroundColor( 2 == selectedBottomNavBarItemIndex ? Color(red: 212/255, green: 85/255, blue: 85/255)
                                          : Color.black.opacity(0.6))
                        .frame(maxWidth:.infinity)
                }
            }
            
            NavigationLink(tag: 9, selection: $selection) {
                BookmarkView()
            } label: {
                Button {
                    selection = 9
                    selectedBottomNavBarItemIndex = 3
                } label: {
                    Image(systemName: "bookmark")
                        .font(.system(size: 24))
                        .foregroundColor( 3 == selectedBottomNavBarItemIndex ? Color(red: 212/255, green: 85/255, blue: 85/255)
                                          : Color.black.opacity(0.6))
                        .frame(maxWidth:.infinity)
                }
            }
  
            NavigationLink(tag: 10, selection: $selection) {
                SettingView()
            } label: {
                Button {
                    selection = 10
                    selectedBottomNavBarItemIndex = 4
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 24))
                        .foregroundColor( 4 == selectedBottomNavBarItemIndex ? Color(red: 212/255, green: 85/255, blue: 85/255)
                                          : Color.black.opacity(0.6))
                        .frame(maxWidth:.infinity)
                }
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
    @EnvironmentObject var userVm:SignInViewModel
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
                    
                    Image_TitleMenu(userName: "\(userVm.user.ho.uppercased()) \(userVm.user.ten.uppercased())")
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
                Spacer()
                Spacer()
            }
            .background(Color(.white))
            .foregroundColor(Color(#colorLiteral(red: 0.62,green: 0.62,blue: 0.62,alpha: 1)))
            
        }
        .frame(width: UIScreen.main.bounds.width / 1.2)
    }
}

struct Image_TitleMenu: View {
    var userName:String
    var body: some View {
        VStack{
            HStack(spacing: 10) {
                Image(uiImage: #imageLiteral(resourceName: "people"))
                    .resizable()
                    .frame(width: 100, height: 100)
                    .zIndex(1)
                Text(userName)
                    .font(.system(size: 22)).bold()
                    .foregroundColor(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            }.offset(x: 20, y: 25)
        }
    }
}

struct ButtonMenu: View {
    var image:Image
    var name:String
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
    @State private var selection: Int? = 0
    var body: some View {
        VStack(alignment: .leading) {
            NavigationLink(tag: 1, selection: $selection) {
                ProfileView()
            } label: {
                Button {
                    self.selection = 1
                } label: {
                    ButtonMenu(image:Image(systemName: "person"), name: "Hồ sơ")
                }
            }
            
            NavigationLink(tag: 2, selection: $selection) {
                CategoryView()
            } label: {
                Button {
                    self.selection = 2
                } label: {
                    ButtonMenu(image:Image("options-lines"), name: "Thể loại")
                }
            }
            
            NavigationLink(tag: 3, selection: $selection) {
                BookmarkView()
            } label: {
                Button {
                    self.selection = 3
                } label: {
                    ButtonMenu(image:Image("bookmark"), name: "Bookmark")
                }
            }
            
            NavigationLink(tag: 4, selection: $selection) {
                SettingView()
            } label: {
                Button {
                    self.selection = 4
                } label: {
                    ButtonMenu(image:Image("settings"), name: "Cài đặt")
                }
            }
        }
    }
}

struct ButtonMenuBelow: View {
    @EnvironmentObject var userVm:SignInViewModel
    @State private var selection: Int? = 0
    var body: some View{
        VStack(alignment: .leading) {
            Button(action: {
                guard let url = URL(string: "https://docs.swift.org/swift-book/"), UIApplication.shared.canOpenURL(url)
                else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }) {
                ButtonMenu(image:Image("browser"), name: "Truy cập website")
            }
            
            NavigationLink(tag: 2, selection: $selection) {
                CategoryView()
            } label: {
                Button {
                    self.selection = nil
                } label: {
                    ButtonMenu(image:Image("star"), name: "Đánh giá 5 sao")
                }
            }
            
            NavigationLink(tag: 20, selection: $selection) {
                SignInView()
            } label: {
                Button {
                    userVm.user = User()
                    userVm.isLoggedIn = false
                    userVm.removeAllLoadingListeners()
                    self.selection = 20
                    
                } label: {
                    ButtonMenu(image:Image("close"), name: "Đăng xuất")
                }
            }
            
            NavigationLink(tag: 4, selection: $selection) {
                HomeView()
            } label: {
                Button {
                    self.selection = nil
                } label: {
                    ButtonMenu(image:Image("settings"), name: "Chính sách bảo mật")
                }
            }
        }
    }
}





