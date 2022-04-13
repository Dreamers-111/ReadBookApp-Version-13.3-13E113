//
//  BookChapter.swift
//  ReadBook
//
//  Created by XuanHuy on 12/04/2022.
//

import Foundation

struct BookChapter{
    
    @propertyWrapper
    struct fixNewLineForString{
        private var str = ""
        var wrappedValue:String {
            get {return str.replacingOccurrences(of: "\\n", with: "\n")}
            set {str = newValue}
        }
    }
    
    var name:String
    @fixNewLineForString var content:String
    
    init(){
        name = ""
        content = ""
    }
    init(name:String, content:String){
        self.name = name
        self.content = content
    }
}


