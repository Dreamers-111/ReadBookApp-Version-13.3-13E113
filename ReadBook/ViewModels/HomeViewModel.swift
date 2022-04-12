//
//  HomeViewModel.swift
//  ReadBook
//
//  Created by XuanHuy on 08/04/2022.
//

import Foundation
import FirebaseFirestore

final class HomeViewModel: ObservableObject{

    @Published public private(set) var books1:[Book] = []
    @Published public private(set) var books2:[Book] = []
    @Published public private(set) var categories:[BookCategory] = []

    public private(set) var loadingListeners:[ListenerRegistration] = []
    public private(set) var searchingListeners:[ListenerRegistration] = []

    
    private let db = Firestore.firestore()
    
    func fetchBookCategories() -> Void {
       let listener =  db.collection("categories").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else {
                print("No documents")
                print(error!)
                return
            }
            
            self.categories = documents.map { document -> BookCategory in
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let id = document.documentID
                return BookCategory(id: id, name: name)
            }
        }
        
        loadingListeners.append(listener)
        
    }
    
    func fetchBooks() -> Void {
       let listener1 = db.collection("books").addSnapshotListener { snapshot, error in
            guard let documents = snapshot?.documents, error == nil else{
                print("No documents")
                return
            }
            self.books2 = documents.map { document -> Book in
                let data = document.data()
                let id = document.documentID
                let title = data["title"] as? String ?? ""
                let author = data["author"] as? String ?? ""
                let imageName = data["imageName"] as? String ?? ""
                var category = ""
                let totalChapters = data["totalChapters"] as? Int ?? 0
                let book = Book(id: id, title: title, category: category, author: author, imageName: imageName, totalChapters: totalChapters)
                
                guard let categoryRef = data["category"] as? DocumentReference else{
                    print("Book with id: \(id) have invalid category")
                    return Book(id: id, title: title, category: category, author: author, imageName: imageName, totalChapters: totalChapters)
                }
                
                let listener2 = categoryRef.addSnapshotListener { document, error in
                    guard let data = document?.data(), error == nil else{
                        print("No category")
                        return
                    }
                    category = data["name"] as? String ?? ""
                    book.category = category
                }
                self.loadingListeners.append(listener2)
                return book
            }
        }
        self.loadingListeners.append(listener1)
    }
    
    
    func fetchBooksByCategory(categoryId:String) -> Void {
        let listener1 = db.collection("books")
            .whereField("category", isEqualTo: db.collection("categories").document(categoryId))
            .addSnapshotListener { snapshot, error in
             guard let documents = snapshot?.documents, error == nil else{
                 print("No documents")
                 return
             }
             self.books1 = documents.map { document -> Book in
                 let data = document.data()
                 let id = document.documentID
                 let title = data["title"] as? String ?? ""
                 let author = data["author"] as? String ?? ""
                 let imageName = data["imageName"] as? String ?? ""
                 var category = ""
                 let totalChapters = data["totalChapters"] as? Int ?? 0
                 let book = Book(id: id, title: title, category: category, author: author, imageName: imageName, totalChapters: totalChapters)
                 
                 guard let categoryRef = data["category"] as? DocumentReference else{
                     print("Book with id: \(id) have invalid category")
                     return Book(id: id, title: title, category: category, author: author, imageName: imageName, totalChapters: totalChapters)
                 }
                 
                 let listener2 = categoryRef.addSnapshotListener { document, error in
                     guard let data = document?.data(), error == nil else{
                         print("No category")
                         return
                     }
                     category = data["name"] as? String ?? ""
                     book.category = category
                 }
                 self.searchingListeners.append(listener2)
                 return book
             }
         }
         self.searchingListeners.append(listener1)
    }
    
    func removeAllLoadingListeners() -> Void {
        for listener in loadingListeners {
            listener.remove()
        }
        loadingListeners = []
    }
    
    func removeAllSearchingListeners() -> Void {
        for listener in searchingListeners {
            listener.remove()
        }
        searchingListeners = []
    }
    
    func removeAllListeners() -> Void {
        removeAllLoadingListeners()
        removeAllSearchingListeners()
    }
}
