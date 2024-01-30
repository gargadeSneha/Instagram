//
//  PostService.swift
//  Instagram
//
//  Created by Sneha Gargade on 05/09/23.
//

import Foundation
import Firebase

struct PostService {
    
    private let postCollection = Firestore.firestore().collection("post")
    
    func fetchFeedPost() async throws -> [Post]{
        let snapShot = try await postCollection.getDocuments()
       var posts = try snapShot.documents.compactMap({ try $0.data(as: Post.self) })
        
        for i in 0..<posts.count {
            let post = posts[i]
            let ownerUid = post.ownerUid
            let postUser = try await UserService.fetchUser(withUid: ownerUid)
            posts[i].user = postUser
        }
        return posts
    }
    
   func fetchUsersPost(uid: String) async throws -> [Post]{
        let snapShot  = try await postCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return try snapShot.documents.compactMap({ try $0.data(as: Post.self) })
    }
}
