//
//  BookChapter.swift
//  ReadBook
//
//  Created by XuanHuy on 12/04/2022.
//

import Foundation

struct BookChapter{
    var name:String
    var content:String
    init(){
        name = ""
        content = ""
    }
    init(name:String, content:String){
        self.name = name
        self.content = content
    }
}


