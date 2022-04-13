//
//  BookChapterView.swift
//  ReadBookApp
//
//  Created by Hùng on 25/03/2022.
//

import SwiftUI


struct BookChapterView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    var title:String
    var name:String
    var content:String
    @State private var selectedBottomNavBarItemIndex = 0
    @State var textSize:CGFloat = 16.0
    @State var isHide = true
    var body: some View {
        ZStack {
            ZStack {
                ScrollView(showsIndicators: false){
                    
                    VStack(alignment: .leading){
                        
                        contentChap_TextView(content: self.content, textSize: self.$textSize)
                            .padding(.horizontal)
                            .padding(.bottom)
                            .padding(.bottom)
                            .padding(.bottom)
                        
                        
                        Spacer()
                        
                    }
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading:
                                        CustomBackButtonView(
                                            action:{
                                                presentationMode.wrappedValue.dismiss()
                                            }),
                                    trailing:
                                        CustomThreeDotsButtonView(
                                            action:{
                                                self.isHide = !self.isHide
                                            })
                )
                .navigationBarTitle(title + " - " + name, displayMode: .inline)
                
                bottomNavBar()
            }
            
            changeFont_View(textSize: self.$textSize, isHide: self.$isHide)
                .opacity(isHide ? 0 : 1)
            
        }
    }
}

struct changeFont_View: View {
    
    @State private var isEditing = false
    @Binding var textSize:CGFloat
    @Binding var isHide:Bool
    var body: some View {
        VStack {
            
            CustomExitButtonView(action:{
                self.isHide = true
            })
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .topTrailing)
            
            Slider(
                value: $textSize,
                in: 5...30,
                step: 1
            ) {
                Text("Font size")
            } minimumValueLabel: {
                Text("5")
            } maximumValueLabel: {
                Text("30")
            } onEditingChanged: { editing in
                isEditing = editing
            }
            .padding(.horizontal)
            
            Text("Kích cỡ chữ: \(Int(textSize))")
                .foregroundColor(isEditing ? .red : .blue)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.bottom)
                .padding(.horizontal)
            
        }
        .background(Color.white)
        .shadow(color: Color.black.opacity(0.3), radius: 3)
        .frame(maxHeight:.infinity,alignment: .bottom)
        .edgesIgnoringSafeArea(.bottom)
        
    }
}


struct CustomBackButtonView: View {
    let action: () -> Void
    var body: some View {
        Button(action: action,
               label: {
            Image(systemName: "arrow.backward")
                .padding(.vertical,12)
        }
        )
        .foregroundColor(.black)
    }
}

struct CustomThreeDotsButtonView: View {
    let action: () -> Void
    var body: some View {
        Button(action: action,
               label: {
            Image("threeDot")
                .resizable()
                .frame(width: 5, height: 20)
        }
        )
        .foregroundColor(.black)
    }
}

struct CustomExitButtonView: View {
    let action: () -> Void
    var body: some View {
        Button(action: action,
               label: {
            Image("close")
                .resizable()
                .frame(width: 15, height: 15)
                .padding()
        })
        .foregroundColor(.black)
    }
}

struct contentChap_TextView: View {
    var content:String
    @Binding var textSize:CGFloat
    var body: some View {
        Text(content)
            .font(.system(size: textSize))
            .multilineTextAlignment(.leading)
            .foregroundColor(Color(red: 0.62, green: 0.62, blue: 0.62).opacity(1))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct BookChapterView_Previews: PreviewProvider {
    static var previews: some View {
        BookChapterView(title: "", name: "", content: "")
    }
}

