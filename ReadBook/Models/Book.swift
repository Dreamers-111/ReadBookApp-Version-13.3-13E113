//
//  Books.swift
//  ReadBook
//
//  Created by XuanHuy on 08/04/2022.
//

import Foundation
import SwiftUI

class Book{
    let id: String
    let title:String
    let category:String
    let author:String
    let about_author:String
    private let imageName:String
    var image:Image{
        Image(imageName)
    }
    init(id: String, title:String, category:String, author:String, about_author:String, imageName:String){
        self.id = id
        self.title = title
        self.category = category
        self.author = author
        self.about_author = about_author
        self.imageName = imageName
    }
}
