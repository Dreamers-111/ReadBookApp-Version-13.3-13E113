//
//  HomeViewModel.swift
//  ReadBook
//
//  Created by XuanHuy on 08/04/2022.
//

import Foundation
import FirebaseFirestore

final class HomeViewModel: ObservableObject{
    @Published var books:[Book] = []
    @Published var categories:[BookCategory] = []
    @Published var muuubool:[Int] = []
    
    private var db = Firestore.firestore()
    
    func fectchBookCategories() -> Void {
        db.collection("categories").getDocuments { querrySnapshot, error in
            guard let documents = querrySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.categories = documents.map { querryDocumentSnapshot -> BookCategory in
                let data = querryDocumentSnapshot.data()
                let name = data["name"] as? String ?? ""
                let id = querryDocumentSnapshot.documentID
                return BookCategory(id: id, name: name)
            }
        }
        
    }
    
}
