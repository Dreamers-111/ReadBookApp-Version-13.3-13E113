//
//  Books.swift
//  ReadBook
//
//  Created by XuanHuy on 08/04/2022.
//

import Foundation
import SwiftUI

class Book:Identifiable{
    let id:String
    let title:String
    var category:String
    let author:String
    let totalChapters:Int
    
    private let imageName:String
    var image:Image{
        Image(imageName)
    }

    var aboutAuthor:String!
    var description:String!
    var chapters:[BookChapter] = []
    
    init(id:String, title:String, category:String, author:String, imageName:String, totalChapters:Int){
        self.id = id
        self.title = title
        self.category = category
        self.author = author
        self.imageName = imageName
        self.totalChapters = totalChapters
    }

}

