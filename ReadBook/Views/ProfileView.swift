//
//  ProfileView.swift
//  ReadBook
//
//  Created by Phan Tam Nhu on 15/04/2022.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @EnvironmentObject var userVm:SignInViewModel
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Image("people")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 100)
                            .stroke(Color(#colorLiteral(red: 0.12941177189350128, green: 0.7215686440467834, blue: 0.572549045085907, alpha: 1)), lineWidth: 4))
                    .frame(width: 200, height: 200, alignment: .center)
                name_tick(userName: "\(userVm.user.ho) \(userVm.user.ten)")
            }
            
            Form {
                Section(header: Text("Basic Infomation").font(.system(size: 15)).bold().foregroundColor(Color.black)) {
                    FormRowInfoBasic(hoten: "\(userVm.user.ho) \(userVm.user.ten)", gioitinh: "\(userVm.user.gioitinh)")
//                    , ngaysinh: "\(DateFormatter.string(userVm.user.ngaysinh))"
                }
                Section(header: Text("Account Infomation").font(.system(size: 15)).bold().foregroundColor(Color.black)) {
                    FormRowInfoAccount(email: "\(userVm.user.email)", password: "\(userVm.user.password)")
                }
            }
 
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView (
                                action:{
                                    presentationMode.wrappedValue.dismiss()
                                })
                            )
        .navigationBarTitle("HỒ SƠ", displayMode: .inline)
    }
}

struct name_tick: View {
    var userName:String
    var body: some View {
        HStack(spacing: 10) {
            Text(userName)
                .font(.system(size: 25)).bold()
            
            Image("checked")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

struct Info: View {
    var firstText: String
    var secondText: String
    var icon: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(#colorLiteral(red: 0.12941177189350128, green: 0.7215686440467834, blue: 0.572549045085907, alpha: 1)))
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

struct FormRowInfoBasic: View {
    @EnvironmentObject var userVm:SignInViewModel
    var hoten: String
    var gioitinh: String
//    var ngaysinh: Date
    
    var body: some View {
        Info(firstText: "Họ & Tên", secondText: hoten, icon: "person.fill")
        Info(firstText: "Giới tính", secondText: gioitinh, icon: "person.2.fill")
//        Info(firstText: "Ngày sinh", secondText: "\(ngaysinh)", icon: "calendar.circle.fill")
    }
}

struct FormRowInfoAccount: View {
    var email: String
    var password: String
    
    var body: some View {
        Info(firstText: "Email", secondText: email, icon: "person.crop.circle.fill.badge.checkmark")
        Info(firstText: "Password", secondText: password, icon: "lock.fill")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
