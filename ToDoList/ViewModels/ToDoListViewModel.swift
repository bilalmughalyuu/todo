//
//  ToDoListViewModel.swift
//  ToDoList
//
//  Created by Bilal on 12/06/2024.
//

import Foundation
import FirebaseFirestore

class ToDoListViewModel: ObservableObject {
    @Published var isShowing: Bool = false
    
    init() {
        
    }
    
    private var db = Firestore.firestore()
    
    func deleteItem (itemId: String, userId: String) {
        db.collection("users/\(userId)/todos").document(itemId).delete { error in
            if let error = error {
                print("Error removing document: \(error)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func toggleIsCheck(item: ToDoListItem, userId: String) {
        var newItem = item
        newItem.setDone(!item.isDone)
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(newItem.id)
            .setData(newItem.asDictionary())
    }
}
