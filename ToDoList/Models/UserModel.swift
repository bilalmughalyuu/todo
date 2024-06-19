//
//  User.swift
//  ToDoList
//
//  Created by Bilal on 05/06/2024.
//

import Foundation


struct UserModel: Codable {
    let id: String
    let name: String
    let email: String
    let joined: TimeInterval
}
