//
//  SingInViewModel.swift
//  ReadBook
//
//  Created by Hung on 4/12/2022
//

import Foundation
import FirebaseFirestore

final class SignInViewModel: ObservableObject{
    @Published var user = User()
    @Published var isLoggedIn = false
    public private(set) var loadingListeners:[ListenerRegistration] = []
    private let db = Firestore.firestore()
    
    func fectchUser(email:String,password:String) -> Void {
       let listener = db.collection("users")
            .whereField("email", isEqualTo: email)
            .whereField("password", isEqualTo: password)
            .addSnapshotListener{ snapshot, error in
                guard let snapshop_ = snapshot, error == nil else {
                    print("error")
                    return
                }
                guard snapshop_.documents != [] else {
                    print("wrong email or password")
                    return
                }
                let documents = snapshop_.documents
                let data = documents[0].data()
                self.user.id = documents[0].documentID
                self.user.ho = data["ho"] as? String ?? ""
                self.user.ten = data["ten"] as? String ?? ""
                self.user.gioitinh = data["gioitinh"] as? String ?? ""
                self.user.ngaysinh = data["ngaysinh"] as? Date
                self.user.email = data["email"] as? String ?? ""
                self.user.password = data["password"] as? String ?? ""
                self.user.bookmark = data["bookBookmark"] as? [String] ?? []
                self.isLoggedIn = true
            }
        loadingListeners.append(listener)
    }
    func removeAllLoadingListeners() -> Void {
        for listener in loadingListeners {
            listener.remove()
        }
        loadingListeners.removeAll()
    }
}
