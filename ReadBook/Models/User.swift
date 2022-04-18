//
//  User.swift
//  ReadBook
//
//  Created by Hùng on 11/04/2022.
//
import Foundation

struct User{
    var id:String
    var ho:String
    var ten:String
    var gioitinh:String
    var ngaysinh: Date!
    var email:String
    var password:String
    var bookmark:[String]
    init(){
        self.id = ""
        self.ho = ""
        self.ten = ""
        self.gioitinh = ""
//      self.ngaysinh = nil
        self.email = ""
        self.password = ""
        self.bookmark = []
    }
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: ngaysinh)
    }
}
