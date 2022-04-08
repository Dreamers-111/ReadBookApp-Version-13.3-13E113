//
//  SignInView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/4/22.
//

import SwiftUI


struct SignInView: View {
    
    @State private  var email = ""
    @State private  var password = ""
    
    var body: some View {
        
     
            VStack(spacing:0)
            {
                imageSignIn()
                titleSignIn()
                    .padding(.vertical)
                subtitleSighIn()
                    .padding(.bottom)
                    .padding(.bottom)
                UserInput2(fontsize:18, email: $email, password: $password)
                    .padding(.top)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.horizontal)
                Buttons2(email: $email, password: $password)
                    .padding(.top)
                    .padding(.top)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .ignoresSafeArea(edges: .top)
        
        
    }
}


struct UserInput2: View {
    let fontsize:CGFloat
    @Binding var email:String
    @Binding var password:String
    
    var body: some View {
        VStack(spacing:0){
            //Email
            myTextField1(type: "text",
                         fontsize: fontsize,
                         placeholder: "Email", text: $email,
                         prompt: "")

            //Password
            myTextField1(type: "password",
                         fontsize: fontsize,
                         placeholder: "Mật khẩu", text: $password,
                         prompt: "")
        }
    }
}

struct Buttons2: View {
    
    @Binding var email:String
    @Binding var password:String
    @State private var selection: Int? = nil
    
    var body: some View {
        VStack(spacing:0){
            NavigationLink(tag: 3, selection: $selection) {
                HomeView()
            } label: {
                Button {
                    if email == "" && password == "" {
                        self.selection = 3
                    }
                } label: {
                    Text("ĐĂNG NHẬP")
                        .font(.custom("Poppins Regular", size: 16))
                        .foregroundColor(.white)
                        .tracking(1)
                        .padding(.all,10)
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .background(Color(red: 0.12941177189350128,
                                          green: 0.7215686440467834,
                                          blue: 0.572549045085907))
                        .cornerRadius(16)
                }
            }
            .padding(.bottom)

            NavigationLink(tag: 2, selection: $selection) {
                SignUpView()
            } label: {
                Button {
                    self.selection = 2
                } label: {
                        Text("Bạn chưa có tài khoản?")
                            .font(.custom("Poppins Regular", size: 14))
                            .foregroundColor(Color(red: 0.71,
                                                   green: 0.71,
                                                   blue: 0.71))
                            .padding(.top,5)
                            .overlay(
                                VStack{
                                    RoundedRectangle(cornerRadius: 1)
                                        .fill(Color(red: 0.12941177189350128,
                                                    green: 0.7215686440467834,
                                                    blue: 0.572549045085907))
                                        .frame(maxWidth: .infinity, maxHeight: 1)
                                    
                                    Spacer()
                                }
                            )
                }
            }
            .padding(.bottom)
                 
            
            NavigationLink(tag: 1, selection: $selection) {
                SignUpView()
            } label: {
                Button {
                    self.selection = 1
                } label: {
                    Image(systemName: "chevron.up")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.12941177189350128,
                                               green: 0.7215686440467834,
                                               blue: 0.572549045085907))
                }
            }
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

struct imageSignIn: View {
    var body: some View {
        Image("signin")
            .resizable()
            .aspectRatio(contentMode: .fill)
    }
}

struct titleSignIn: View {
    var body: some View {
        Text("D R E A M E R S")
            .font(.system(size: 36))
            .fontWeight(.heavy)
            .foregroundColor(Color(red: 0.13,
                                   green: 0.72,
                                   blue: 0.57))
            .tracking(4)
            .multilineTextAlignment(.center)
    }
}

struct subtitleSighIn: View {
    var body: some View {
        Text("- WORDS HAVE POWER - ")
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(Color(red: 0.13,
                                   green: 0.72,
                                   blue: 0.57))
            .tracking(4)
            .multilineTextAlignment(.center)
    }
}
