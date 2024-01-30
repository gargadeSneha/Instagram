//
//  FeedViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 05/09/23.
//

import Foundation
import Firebase

class FeedViewModel: ObservableObject {
     
    @Published var posts = [Post]()
    
    init(){
        Task{
            try await fetchPosts()
        }
    }
    @MainActor
    func fetchPosts() async throws {
        self.posts = try await PostService().fetchFeedPost()
    }
    
}
