//
//  UserService.swift
//  Instagram
//
//  Created by Sneha Gargade on 30/08/23.
//

import Foundation
import Firebase

struct UserService {
    
//   static func fetchAllUser() async throws -> [User] {
//       var users = [User]()
//        let snapShot = try await Firestore.firestore().collection("users").getDocuments()
//        let documents = snapShot.documents
//
//        for doc in documents {
////            MARK: we get all the data of users in array using print stat
////            print(doc.data())
//            guard let user = try? doc.data(as: User.self) else { return users }
//            users.append(user)
//        }
//       return users
//    }
    
    //Another Method

    static func fetchAllUser() async throws -> [User] {
         let snapShot = try await Firestore.firestore().collection("users").getDocuments()
        return snapShot.documents.compactMap({try? $0.data(as: User.self)})
    
     }
    
    static func fetchUser(withUid uid: String) async throws -> User {
        let snapShot = try await Firestore.firestore().collection("users").document(uid).getDocument()
        return try snapShot.data(as: User.self)
    
     }
}
