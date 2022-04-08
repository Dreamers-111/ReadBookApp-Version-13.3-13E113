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
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    init(){
        FirebaseApp.configure()
    }
}
