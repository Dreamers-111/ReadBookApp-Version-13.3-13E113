//
//  Books.swift
//  ReadBook
//
//  Created by XuanHuy on 08/04/2022.
//

import Foundation
import SwiftUI

class Book:Identifiable{
    
    @propertyWrapper
    struct fixNewLineForString{
        private var str:String!
        var wrappedValue:String! {
            get {return str.replacingOccurrences(of: "\\n", with: "\n")}
            set {
                if newValue != nil{
                    str = newValue
                }
                else{
                    print("New value for string is nil!")
                }
            }
        }
    }
    
    var id:String
    var title:String
    var category:String
    var author:String
    var totalChapters:Int
    var imageName:String
    var image:Image{
        Image(imageName)
    }


    @fixNewLineForString var aboutAuthor:String!
    @fixNewLineForString var description:String!
    var chapters:[BookChapter]!
    
    init(){
        self.id = ""
        self.title = ""
        self.category = ""
        self.author = ""
        self.imageName = ""
        self.totalChapters = 0
        self.aboutAuthor = ""
        self.description = ""
        self.chapters = [BookChapter()]
    }
    init(id:String, title:String, category:String, author:String, imageName:String, totalChapters:Int){
        self.id = id
        self.title = title
        self.category = category
        self.author = author
        self.imageName = imageName
        self.totalChapters = totalChapters
    }
}

