//
//  BookPreviewViewModel.swift
//  ReadBook
//
//  Created by XuanHuy on 12/04/2022.
//

import Foundation
import FirebaseFirestore

final class BookPreviewViewModel: ObservableObject{
    
    @Published public private(set) var books = [Book()]
    @Published public private(set) var isBookmark:Bool = false
    
    public private(set) var loadingListeners:[ListenerRegistration] = []
    
    private let db = Firestore.firestore()
    
    func fetchBookById(bookId:String) -> Void {
        let listener1 = db.collection("books").document(bookId).addSnapshotListener { document, error in
            guard let data = document?.data(),error == nil else{
                print("No book with id \(bookId)")
                return
            }
            
            let book = Book()
            book.id = bookId
            book.title = data["title"] as? String ?? ""
//          book.category = ""
            book.author = data["author"] as? String ?? ""
            book.totalChapters = data["totalChapters"] as? Int ?? 0
            book.imageName = data["imageName"] as? String ?? ""
//          book.aboutAuthor = ""
//          book.description = ""
//          book.chapters = [BookChapter()]
            
       
            guard let categoryRef = data["category"] as? DocumentReference else{
                print("Book with id: \(bookId) have invalid category field")
                return
            }
            
            let listener2 = categoryRef.addSnapshotListener { document, error in
                guard let data = document?.data(), error == nil else{
                    print("No category reference is found")
                    return
                }
                book.category = data["name"] as? String ?? ""
            }
            
            
            let listener3 = self.db.collection("books").document(bookId).collection("bookContent").addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents, error == nil else{
                    print("No book content")
                    return
                }
                let data = documents[0].data()
                book.aboutAuthor = data["aboutAuthor"] as? String ?? ""
                book.description = data["description"] as? String ?? ""
                book.chapters = (data["chapters"] as? [Dictionary<String, Any>] ?? [["chapterName":"Lỗi","chapterContent":"Lỗi"]])
                    .map({ dictionary -> BookChapter in
                    return BookChapter(name: dictionary["chapterName"] as? String ?? "",
                                       content: dictionary["chapterContent"] as? String ?? "")
                })
                self.books = [book]
            }
            self.loadingListeners.append(listener2)
            self.loadingListeners.append(listener3)
        }
        loadingListeners.append(listener1)
    }
    
    func checkBookIsBookmarkById(bookId:String, userBookmark:[String]) -> Void {
        
        if userBookmark.contains(bookId)
        {
            
            self.isBookmark = true
            return
        }
        self.isBookmark = false
        
    }
    
    func removeAllLoadingListeners() -> Void {
        for listener in loadingListeners {
            listener.remove()
        }
        loadingListeners.removeAll()
    }
}
