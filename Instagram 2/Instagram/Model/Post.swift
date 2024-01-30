//
//  Post.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI
import Firebase
 
struct Post: Identifiable,Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timeStamp: Timestamp
//    let videoUrl: String?
    var user: User?
    
}
extension Post {
    static var MOCK_POST: [Post] = [
        .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is some test caption for now", likes: 123, imageUrl: "batman-1", timeStamp: Timestamp(), user: User.MOCK_USERS[0]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is some test caption for now", likes: 150, imageUrl: "spider-man", timeStamp: Timestamp(), user: User.MOCK_USERS[1]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is some test caption for now", likes: 250, imageUrl: "iron-man", timeStamp: Timestamp(),  user: User.MOCK_USERS[2]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is some test caption for now", likes: 159, imageUrl: "Nature1", timeStamp: Timestamp(), user: User.MOCK_USERS[3]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is some test caption for now", likes: 147, imageUrl: "ProfileImg", timeStamp: Timestamp(),  user: User.MOCK_USERS[3]),
        
            .init(id: NSUUID().uuidString, ownerUid: NSUUID().uuidString, caption: "This is some test caption for now", likes: 147, imageUrl: "ProfileImg", timeStamp: Timestamp(), user: User.MOCK_USERS[4])
    ]
}
