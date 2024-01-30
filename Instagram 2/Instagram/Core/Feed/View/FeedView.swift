//
//  FeedView.swift
//  Instagram
//
//  Created by Sneha Gargade on 23/08/23.
//

import SwiftUI

struct FeedView: View {
    
    @StateObject var viewModel = FeedViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView{
                LazyVStack(spacing: 30){
                    ForEach(viewModel.posts) { post in
                        let _ = print(post)
                        FeedCells(post: post)
                    }
                }
                .padding(.top, 8)
            }.navigationTitle("Feed")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Image("Insta_logo")
                            .resizable()
                            .frame(width: 100, height: 32)
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                       Image(systemName: "paperplane")
                            .imageScale(.large)
                           
                    }
                }
        }.onAppear{
            Task{
                let _ = try? await FeedViewModel().fetchPosts()
            }
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
