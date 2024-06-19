//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Bilal on 05/06/2024.
//
import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
