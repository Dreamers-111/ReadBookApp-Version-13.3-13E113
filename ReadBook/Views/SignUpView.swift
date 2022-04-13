//
//  SignUpView.swift
//  ReadBookApp
//
//  Created by Như Phan on 3/4/22.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var viewModel = SignUpViewModel()
    
    var body: some View {
        ScrollView(showsIndicators:false) {
            VStack(spacing:0) {
                titleSignUpView()
                imageSignUpView().padding()
                subtitleSignUpView()
                userInputSignUpView(fontsize: 16,
                          ho: $viewModel.ho,
                          ten: $viewModel.ten,
                          gioitinh: $viewModel.gioitinh,
                          ngaysinh: $viewModel.ngaysinh,
                          email: $viewModel.email,
                          password: $viewModel.password,
                          confirmPassword: $viewModel.confirmPassword,
                          
                          emailPrompt: viewModel.emailPrompt,
                          passwordPrompt: viewModel.passwordPrompt,
                          confirmPasswordPrompt: viewModel.confirmPasswordPrompt)
                    .padding(.top)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    .padding(.horizontal)
                
                Buttons(submit: {viewModel.signUp()},
                        canSubmit: $viewModel.canSubmit)
                    .padding(.top)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}

struct titleSignUpView: View {
    var body: some View {
        Text("D R E A M E R S")
            .font(.system(size: 36))
            .fontWeight(.heavy)
            .foregroundColor(Color(red: 0.13, green: 0.72, blue: 0.57))
            .tracking(4)
            .multilineTextAlignment(.center)
    }
}

struct imageSignUpView: View {
    var body: some View {
        Image("signup")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .cornerRadius(300)
            .overlay(
                RoundedRectangle(cornerRadius: 300)
                    .stroke(Color(red: 0.129, green: 0.722, blue: 0.573), lineWidth: 1)
            )
    }
}

struct subtitleSignUpView: View {
    var body: some View {
        Text("- WORDS HAVE POWER - ")
            .font(.system(size: 14))
            .fontWeight(.medium)
            .foregroundColor(Color(red: 0.13, green: 0.72, blue: 0.57))
            .tracking(4)
            .multilineTextAlignment(.center)
    }
}

struct userInputSignUpView: View {
    
    var fontsize:CGFloat
    @Binding  var ho: String
    @Binding  var ten: String
    @Binding  var gioitinh: String
    @Binding  var ngaysinh: Date
    @Binding  var email: String
    @Binding  var password: String
    @Binding  var confirmPassword: String
    
    var emailPrompt:String
    var passwordPrompt:String
    var confirmPasswordPrompt:String

    let dateRange: PartialRangeThrough<Date> = {
        return ...Calendar.current.date(byAdding: .year, value: -12, to: Date())!
    }()
    
    var body: some View {
        VStack(spacing:0){
            //Họ
            myTextField1(type: "text",
                         fontsize: fontsize,
                         placeholder: "Họ", text: $ho,
                         prompt: "")
            
            //Tên
            myTextField1(type: "text",
                         fontsize: fontsize,
                         placeholder: "Tên", text: $ten
                         ,
                         prompt: "")
            //Giới tính
            myTextField1(type: "gender",
                         fontsize: fontsize,
                         placeholder: "Giới tính", text: $gioitinh,
                         prompt: "")
            
            //Ngày sinh
                DatePicker(selection: $ngaysinh,
                           in: dateRange,
                           displayedComponents: .date) {
                        Text("Birthday")
                            .font(.system(size: fontsize))
                            .foregroundColor(Color(red: 0.129, green: 0.722, blue: 0.573))
                }
                .accentColor(Color(red: 0.129, green: 0.722, blue: 0.573))
                .padding(.bottom)
             

            //Email
            myTextField1(type: "text",
                         fontsize: fontsize,
                         placeholder: "Email", text: $email,
                         prompt: emailPrompt)

            //Password
            myTextField1(type: "password",
                         fontsize: fontsize,
                         placeholder: "Mật khẩu", text: $password,
                         prompt: passwordPrompt)

            //ConfirmPassword
            myTextField1(type: "password",
                         fontsize: fontsize,
                         placeholder: "Xác nhận", text: $confirmPassword,
                         prompt: confirmPasswordPrompt)
        }
    }
}

struct Buttons: View {
    
    let submit:()->Void
    @Binding  var canSubmit: Bool
    @State private var selection: Int? = nil
    
    var body: some View {
        VStack(spacing:0){
            Button {
                submit()
            } label: {
                Text("ĐĂNG KÝ")
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
            .padding(.bottom)
            .padding(.bottom)
            .opacity(canSubmit ? 1 : 0.6)
            .disabled(!canSubmit)

    
                        
            NavigationLink(tag: 1, selection: $selection) {
                SignInView()
            } label: {
                Button {
                    self.selection = 1
                } label: {
                    Image(systemName: "chevron.down")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.12941177189350128,
                                               green: 0.7215686440467834,
                                               blue: 0.572549045085907))
                        
                }
            }
            
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}


