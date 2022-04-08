//
//  myTextField1.swift
//  ReadBookApp
//
//  Created by Duong Huy on 27/03/2022.
//

import SwiftUI

struct myTextField1: View {
    let type: String
    let fontsize: CGFloat
    let placeholder: String
    @Binding var text: String
    let prompt: String
    @State private var hideText = true
    var body: some View {
        if type == "password"{
            VStack(alignment: .leading, spacing: fontsize/4) {
                HStack(spacing:0){
                    if hideText{
                        SecureField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .font(.system(size: fontsize))
                    }
                    else {
                        TextField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .font(.system(size: fontsize))
                    }
                  
                       
                    
                    Button {
                        hideText.toggle()
                    } label: {
                        Image(systemName: hideText ? "eye.slash.fill" : "eye.fill")
                            .font(.system(size: fontsize+3))
                            .foregroundColor(hideText ?  Color.secondary : Color.green )
                            .padding(.leading)
                    }
                    
                }
                .padding(.vertical,fontsize/2)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 300)
                        .stroke(Color(red: 0.129, green: 0.722, blue: 0.573), lineWidth: 1)
                )
                if prompt != "" {
                    Text(prompt)
                        .font(.system(size: fontsize-3))
                        .italic()
                        .padding(.leading)
                }
            }
            .padding(.bottom)
            .animation(.default)

        }
        else if type == "gender"{
            VStack(alignment: .leading, spacing: fontsize/4) {
                HStack(spacing:0) {
                    TextField(placeholder, text: $text)
                        .autocapitalization(.none)
                        .font(.system(size: fontsize))
                        .disabled(true)
                    
                    Button {
                        text = "Nam"
                    } label: {
                        Image("Male-icon")
                            .resizable()
                            .frame(width: fontsize+6, height: fontsize+6)
                    }

                    Button {
                        text = "Nữ"
                    } label: {
                        Image("Female-icon")
                            .resizable()
                            .frame(width: fontsize+6, height: fontsize+6)
                            .padding(.leading)
                    }
                }
                .padding(.vertical,fontsize/2)
                .padding(.horizontal)
                .overlay(
                    RoundedRectangle(cornerRadius: 300)
                        .stroke(Color(red: 0.129, green: 0.722, blue: 0.573), lineWidth: 1)
                )
                if prompt != "" {
                    Text(prompt)
                        .font(.system(size: fontsize-3))
                        .italic()
                        .padding(.leading)
                }
            }
            .padding(.bottom)
            .animation(.default)
        }
        else // "text"
        {
            VStack(alignment: .leading, spacing: fontsize/4) {
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .font(.system(size: fontsize))
                    .padding(.vertical,fontsize/2)
                    .padding(.horizontal)
                    .overlay(
                        RoundedRectangle(cornerRadius: 300)
                            .stroke(Color(red: 0.129, green: 0.722, blue: 0.573), lineWidth: 1)
                    )

                if prompt != "" {
                    Text(prompt)
                        .font(.system(size: fontsize-3))
                        .italic()
                        .padding(.leading)
                }
            }
            .padding(.bottom)
            .animation(.default)
        }
    }
}

struct myTextField1_Previews: PreviewProvider {
    static var previews: some View {
        myTextField1(type: "text", fontsize: 16, placeholder: "text",text: .constant("Duong Xuan Huy"),prompt: "")
    }
}
