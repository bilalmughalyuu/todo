//
//  RegisterViewModel.swift
//  ToDoList
//
//  Created by Bilal on 12/06/2024.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class RegisterViewModel: ObservableObject {
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    
    @Published var errorMessage = ""
    
    @Published var isPasswordVisible: Bool = false
    
    @Published var isLoading: Bool = false
    
    
    init () {}
    
    
    func register() {
        guard validate() else {
            return
        }
        
        isLoading = true
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard let userId = result?.user.uid else {
                return
            }
            
            self.insertUserRecord(id: userId)
        }
        isLoading = false
    }
    
    private func insertUserRecord(id: String) {
        let newUser = UserModel(id: id, name: fullName, email: email, joined: Date().timeIntervalSince1970)
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(id)
            .setData(newUser.asDictionary())
    }
    
    
    private func validate() -> Bool {
        errorMessage = ""
        
        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty,
                !email.trimmingCharacters(in: .whitespaces).isEmpty,
                !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields"
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter a valid email"
            return false
        }
        
        guard password.count >= 5 else {
            errorMessage = "Password is too short"
            return false
        }
        
        return true
    }
}
