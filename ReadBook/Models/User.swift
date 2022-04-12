//
//  User.swift
//  ReadBook
//
//  Created by Hùng on 11/04/2022.
//
import Foundation
import SwiftUI

class User{
    let id:String
    let email:String
    let password:String
    let gioitinh:String
    let ho:String
    let ten:String
    let ngaysinh: String
    var bookmark:[String]

    init(id:String,email:String, password: String, gioitinh: String, ho:String, ten:String,ngaysinh:String, bookmark:[String]){
        self.id = id
        self.email = email
        self.password = password
        self.gioitinh = gioitinh
        self.ho = ho
        self.ten = ten
        self.ngaysinh = ngaysinh
        self.bookmark = bookmark
    }
}
