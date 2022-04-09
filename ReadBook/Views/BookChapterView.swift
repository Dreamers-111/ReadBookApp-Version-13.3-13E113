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
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false){
                    
                    VStack(alignment: .leading){
                        
                        contentChap_TextView(content: content)
                            .padding(.horizontal)
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
                                            presentationMode.wrappedValue.dismiss()
                                    })
                               )
            .navigationBarTitle(title + " - " + name, displayMode: .inline)
            
            bottomNavBar()
        }

    }

}

struct CustomBackButtonView: View {
    let action: () -> Void
    var body: some View {
        Button(action: action,
            label: {
                Image(systemName: "arrow.backward")
                    .padding(.all,12)
                    .frame(width: 20, height: 20)
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


struct contentChap_TextView: View {
    var content:String
    var body: some View {

        VStack(alignment: .leading){
            ForEach(textIntoArr(content: content), id: \.self)
            {
                text in
                    Text(text)
                    .font(.system(size: 16))
                    .foregroundColor(Color(#colorLiteral(red: 0.62, green: 0.62, blue: 0.62, alpha: 1)))
                
            }
            .padding(.bottom)
        }
    
    }
    
    func textIntoArr(content: String) -> [Substring] {
        let contentArr = content.split(whereSeparator: \.isNewline)
        return contentArr
    }
}

struct BookChapterView_Previews: PreviewProvider {
    static var previews: some View {
        BookChapterView(title: "", name: "", content: "")
    }
}
