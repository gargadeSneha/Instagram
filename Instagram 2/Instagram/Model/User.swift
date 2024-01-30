//
//  User.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import Foundation
import Firebase

struct User: Identifiable,Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullName: String?
    var bio: String?
    let email: String
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "batman", profileImageUrl: nil, fullName: "Shubham Desai", bio: "Happy", email: " "),
        .init(id: NSUUID().uuidString, username: "spiderMan", profileImageUrl: nil, fullName: "Akash Patil", bio: "Cool & Smart", email: "akash@gmail.com"),
        .init(id: NSUUID().uuidString, username: "ironMan", profileImageUrl: nil, fullName: "Aadi Gupta", bio: "Cool", email: "aadi@gmail.com"),
        .init(id: NSUUID().uuidString, username: "NatureLover", profileImageUrl: nil, fullName: "Bhakti Sharma", bio: nil, email: "bhakti@gmail.com"),
        .init(id: NSUUID().uuidString, username: "NaturesLook", profileImageUrl: nil, fullName: "Dhriti Deode", bio: "Cute", email: "dhriti@gmail.com"),
    ]
}
