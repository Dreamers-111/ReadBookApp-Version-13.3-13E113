//
//  BookPreviewViewModel.swift
//  ReadBook
//
//  Created by XuanHuy on 12/04/2022.
//

import Foundation
import FirebaseFirestore

final class BookmarkViewModel: ObservableObject{
    
    @Published public private(set) var booksbookmark:[Book] = []
    
    func fetchBooksBookmark(books:[Book], userBookmark: [String]) -> Void {
        for ele in books {
            if (userBookmark.contains(ele.id))
            {
                booksbookmark = booksbookmark + [ele]
            }
        }
    }
}
