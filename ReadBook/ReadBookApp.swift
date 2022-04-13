//
//  ReadBookApp.swift
//  ReadBook
//
//  Created by XuanHuy on 08/04/2022.
//

import SwiftUI
import Firebase

@main
struct ReadBookApp: App {
    
    @StateObject private var vm = SignInViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
    init(){
        FirebaseApp.configure()
    }
}
