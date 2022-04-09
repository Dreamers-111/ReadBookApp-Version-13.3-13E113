//
//  CategoryView.swift
//  ReadBookApp
//
//  Created by Phan Tam Nhu on 25/03/2022.
//

import SwiftUI

struct CategoryView: View {
    
    
    var body: some View {
        
        NavigationView {
            VStack(spacing: 15) {
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Thể loại")
                        .bold()
                        .font(.system(size: 25))
                    
                    Text("CÁC THỂ LOẠI SÁCH HAY NHẤT HIỆN NAY")
                        .fontWeight(.bold)
                        .font(.system(size: 16.5))
                        .foregroundColor(Color(#colorLiteral(red: 0.13, green: 0.72, blue: 0.57, alpha: 1)))
                }

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
            .navigationBarHidden(true)
        }
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
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            khoahocBtnView()
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
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            tamlyBtnView()
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
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            vanhocBtnView()
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
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            langmanBtnView()
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
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            tieuthuyetBtnView()
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
    @State private var action: Int? = 0
    var body: some View {
        NavigationLink(tag: 1, selection: $action) {
            nuocngoaiBtnView()
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
