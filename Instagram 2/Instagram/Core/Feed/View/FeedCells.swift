//
//  FeedCells.swift
//  Instagram
//
//  Created by Sneha Gargade on 23/08/23.
//

import SwiftUI
import Kingfisher

struct FeedCells: View {
    
    let post: Post
    
    var body: some View {
        VStack{
            
            //image + username
            HStack{
                if let post = post.user {
                    CircularProfileImageView(user: post, size: .xsmall)
//                    Image(post.profileImageUrl!)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 40, height: 40)
//                        .clipShape(Circle())
//                    Text("hello1")
                    Text(post.username)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
            }.padding(.leading, 8)
            
//            Text("hello")
            //post image
//            Image(post.imageUrl)
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(height: 400)
                .clipShape(Rectangle())
            
            //action buttons
            HStack(spacing: 16){
                Button {
                    print("Like post")
                } label: {
                    Image(systemName: "heart")
                        .imageScale(.large)
                }
                Button {
                    print("Comment on post")
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                Button {
                    print("Share post")
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()

            }
            .padding(.leading, 8)
            .padding(.top, 4)
            .foregroundColor(.black)
            
            //likes
            Text("\(post.likes) likes")
                .font(.subheadline)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 1)
        
            //caption
            HStack{
                Text("\(post.user?.username ?? "") ").fontWeight(.semibold) +
                Text(post.caption)
            }
            .font(.subheadline)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .padding(.top, 0.5)
            
            //Time
            Text("6h ago")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                .padding(.top, 0.5)
                .foregroundColor(.gray)
            
        }
    }
}

struct FeedCells_Previews: PreviewProvider {
    static var previews: some View {
        FeedCells(post: Post.MOCK_POST[1])
    }
}
