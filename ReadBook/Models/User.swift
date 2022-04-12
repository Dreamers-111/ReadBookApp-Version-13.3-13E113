//
//  User.swift
//  ReadBook
//
//  Created by Hùng on 11/04/2022.
//
import Foundation
import SwiftUI

class User{
    var id:String
    var email:String
    var password:String
    var gioitinh:String
    var ho:String
    var ten:String
    var ngaysinh: String
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
