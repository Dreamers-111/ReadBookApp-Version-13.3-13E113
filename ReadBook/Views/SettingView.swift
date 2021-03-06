//
//  SettingView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/10/22.
//

import SwiftUI

struct SettingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedBottomNavBarItemIndex = 4
    
    init(){
            UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Form {
                Section(header: Text("Follow us on social media")) {
                    FormRowLinkView(icon: "globe", color: Color.pink, text: "Website", link: "https://docs.swift.org/swift-book/")
                    FormRowLinkView(icon: "link", color: Color.blue, text: "Facebook", link: "https://facebook.com")
                    FormRowLinkView(icon: "play.rectangle", color: Color.green, text: "Youtube", link: "https://www.youtube.com/")
                }
                
                Section(header: Text("About the application")) {
                    FormRowInfoView(icon: "gear", firstText: "Application", secondText: "ReadBook")
                    FormRowInfoView(icon: "checkmark.seal", firstText: "Compatibility", secondText: "iPhone")
                    FormRowInfoView(icon: "keyboard", firstText: "Developer", secondText: "Huy Nhu Nam")
                    FormRowInfoView(icon: "paintbrush", firstText: "Designer", secondText: "Nam")
                    FormRowInfoView(icon: "flag", firstText: "Version", secondText: "1.0.0")
                    Spacer()
                }
                Spacer()
                Footer()
            }
            bottomNavBar(selectedBottomNavBarItemIndex: $selectedBottomNavBarItemIndex)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView (
                                action:{
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
        .navigationBarTitle("CÀI ĐẶT", displayMode: .inline)
    }
}

struct FormRowLinkView: View {
    var icon: String
    var color: Color
    var text: String
    var link: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(color)
                Image(systemName: icon)
                    .imageScale(.large)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(text)
                .foregroundColor(Color.gray)
            
            Spacer()
            
            Button(action: {
                guard let url = URL(string: link), UIApplication.shared.canOpenURL(url)
                else {
                    return
                }
                UIApplication.shared.open(url as URL)
            }) {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
            }
            .accentColor(Color(.systemGray2))
        }
    }
}


struct FormRowInfoView: View {
    var icon: String
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray)
                Image(systemName: icon)
                    .foregroundColor(Color.white)
            }
            .frame(width: 36, height: 36, alignment: .center)
            
            Text(firstText).foregroundColor(Color.gray)
            Spacer()
            Text(secondText)
        }
    }
}

struct Footer: View {
    var body: some View {
        VStack {
            Text("Copyright © All rights reserved.\nRead Book Apps ♡ Dreamers Team")
                .multilineTextAlignment(.center)
                .font(.footnote)
                .padding(.vertical)
            .foregroundColor(Color.secondary)
        }.frame(maxWidth: .infinity)
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


