//
//  SingInViewModel.swift
//  ReadBook
//
//  Created by Hung on 4/12/2022
//

import Foundation
import FirebaseFirestore

final class SignInViewModel: ObservableObject{
    @Published var user:User = User(id: "", email: "", password:"",gioitinh: "", ho: "", ten: "", ngaysinh: "", bookmark: [])
    
    private let db = Firestore.firestore()
        
    func fectchUser() -> Void {
        db.collection("user")
            .whereField("email", isEqualTo: "nam@gmail.com")
            .whereField("password", isEqualTo: "123123A@")
            .addSnapshotListener { Snapshot, error in
            guard let documents = Snapshot?.documents else {
                print("No documents")
                return
            }
            let data = documents[0].data()
            self.user.id = documents[0].documentID
            self.user.ho = data["ho"] as? String ?? ""
            self.user.ten = data["ten"] as? String ?? ""
            self.user.email = data["email"] as? String ?? ""
            self.user.password = data["password"] as? String ?? ""
            self.user.gioitinh = data["gioitinh"] as? String ?? ""
            self.user.ngaysinh = data["ngaysinh"] as? String ?? ""
            self.user.bookmark = data["bookmark"] as? [String] ?? []
            
        }
        print(self.user.ten)
    }

    

}
