//
//  SignUpViewModel.swift
//  ReadBookApp
//
//  Created by Duong Huy on 27/03/2022.
//

import Foundation
import Combine
import FirebaseFirestore

final class SignUpViewModel: ObservableObject{
    
    private let db = Firestore.firestore()
    
    @Published var ho = ""
    @Published var ten = ""
    @Published var gioitinh = ""
    @Published var ngaysinh = Calendar.current.date(byAdding: .year, value: -12, to: Date())!
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    
    @Published private var isHoValid = false
    @Published private var isTenValid = false
    @Published private var isGioiTinhValid = false
    @Published private var isFirst3Valid = false
    
    @Published private var isEmailCriteriaValid = false
    @Published private var isPasswordCriteriaValid = false
    @Published private var isPasswordConfirmValid = false
    @Published private var isLast3Valid = false
    
    @Published var canSubmit = false
    @Published private var isSubmitFail = false
    
    private var cancellAbleSet: Set<AnyCancellable> = []
    
    private let emailPredicate = NSPredicate(format: "SELF MATCHES %@", #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#)
    
    private let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"#)
    
    init(){
        
        $ho
            .map { ho in
                return ho != ""
            }
            .assign(to: \.isHoValid,on: self)
            .store(in: &cancellAbleSet)
        
        $ten
            .map { ten in
                return ten != ""
            }
            .assign(to: \.isTenValid,on: self)
            .store(in: &cancellAbleSet)
        
        $gioitinh
            .map { gioitinh in
                return gioitinh != ""
            }
            .assign(to: \.isGioiTinhValid,on: self)
            .store(in: &cancellAbleSet)
        
        
        $email
            .map { email in
                return self.emailPredicate.evaluate(with: email)
            }
            .assign(to: \.isEmailCriteriaValid,on: self)
            .store(in: &cancellAbleSet)
        
        $password
            .map { password in
                return self.passwordPredicate.evaluate(with: password)
            }
            .assign(to: \.isPasswordCriteriaValid,on: self)
            .store(in: &cancellAbleSet)
        
        Publishers.CombineLatest($password, $confirmPassword)
            .map { password,confirmPassword in
                return password == confirmPassword
            }
            .assign(to: \.isPasswordConfirmValid,on: self)
            .store(in: &cancellAbleSet)
        
        Publishers.CombineLatest3($isHoValid, $isTenValid, $isGioiTinhValid)
            .map { isHoValid, isTenValid, isGioiTinhValid in
                return isHoValid && isTenValid && isGioiTinhValid
            }
            .assign(to: \.isFirst3Valid,on: self)
            .store(in: &cancellAbleSet)
        
        Publishers.CombineLatest3($isEmailCriteriaValid, $isPasswordCriteriaValid, $isPasswordConfirmValid)
            .map { isEmailCriteriaValid, isPasswordCriteriaValid, isPasswordConfirmValid in
                return  isEmailCriteriaValid && isPasswordCriteriaValid && isPasswordConfirmValid
            }
            .assign(to: \.isLast3Valid,on: self)
            .store(in: &cancellAbleSet)
     
        Publishers.CombineLatest($isFirst3Valid, $isLast3Valid)
            .map { isFirst3Valid, isLast3Valid in
                return isFirst3Valid && isLast3Valid
            }
            .assign(to: \.canSubmit,on: self)
            .store(in: &cancellAbleSet)

    }
        
    var emailPrompt: String{
        if isSubmitFail && email != ""{
            return "Địa chỉ email đã được sử dụng"
        }
        return ""
        
    }
    
    var passwordPrompt: String{
        if !isPasswordCriteriaValid{
            return "Mật khẩu phải có ít nhất 8 kí tự, có ít nhất một chữ số, một chữ cái và một kí tự đặc biệt"
        }
        return ""
        
    }
    
    var confirmPasswordPrompt: String{
        if !isPasswordConfirmValid && confirmPassword != "" && password != ""{
            return "Mật khẩu không khớp"
        }
        return ""
    }
    
    func signUp() -> Void {
        db.collection("users").whereField("email", isEqualTo: email).getDocuments{ snapshot, error in
            guard let snapshop_ = snapshot, error == nil else {
                print("error")
                return
            }
            guard snapshop_.documents == []  else {
                self.isSubmitFail = true
                print("user with id \(self.email) has already existed.")
                return
            }

            self.isSubmitFail = false
            self.db.collection("users").document().setData(["ho":self.ho,
                                                      "ten":self.ten,
                                                      "gioitinh":self.gioitinh,
                                                      "ngaysinh":Calendar.current.startOfDay(for: self.ngaysinh),
                                                      "email":self.email,
                                                      "password":self.password])
            self.ho = ""
            self.ten = ""
            self.gioitinh = ""
            self.ngaysinh = Calendar.current.date(byAdding: .year, value: -12, to: Date())!
            self.email = ""
            self.password = ""
            self.confirmPassword = ""
        }
      
    }
}
