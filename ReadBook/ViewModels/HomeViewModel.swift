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
    @Published var user:[User] = []
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
    
    func fectchUser() -> Void {
        db.collection("user").whereField("email", isEqualTo: "nam@gmail.com").getDocuments { querrySnapshot, error in
            guard let documents = querrySnapshot?.documents else {
                print("No documents")
                return
            }

            self.user = documents.map { querryDocumentSnapshot -> User in
                let data = querryDocumentSnapshot.data()
                let id = querryDocumentSnapshot.documentID
                let ho = data["ho"] as? String ?? ""
                let ten = data["ten"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let password = data["password"] as? String ?? ""
                let gioitinh = data["gioitinh"] as? String ?? ""
                let ngaysinh = data["ngaysinh"] as? String ?? ""
                let bookmark = data["bookmark"] as? [String] ?? []

                return User(id: id, email: email, password: password,gioitinh: gioitinh, ho: ho, ten: ten, ngaysinh: ngaysinh, bookmark: bookmark)
            }
        }
    }

    

}
