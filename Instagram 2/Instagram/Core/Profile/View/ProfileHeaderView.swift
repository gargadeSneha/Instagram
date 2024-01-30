//
//  ProfileHeaderView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI

struct ProfileHeaderView: View {
    let user: User
    @State var showEditProfile = false
    
    var body: some View {
        VStack(spacing: 10){
            //pic and stats
            HStack{
                CircularProfileImageView(user: user, size: .large)
                
                Spacer()
                
                HStack(spacing: 8){
                    UserStackView(value: 4, title: "Post")
                    UserStackView(value: 10, title: "Followers")
                    UserStackView(value: 12, title: "Following")
                }
            }.padding(.horizontal)
          
            //name and bio
            VStack(alignment: .leading, spacing: 2){
                if let fullName = user.fullName {
                    Text(fullName)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                if let bio = user.bio {
                    Text(bio)
                        .font(.footnote)
                }
//                Text(user.username)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            //action button
            Button{
                if user.isCurrentUser {
                    showEditProfile.toggle()
                    print("Show edit profile")
                } else {
                    print("Follow user")
                }
            } label: {
                Text(user.isCurrentUser ? "Edit profile" : "Follow")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(user.isCurrentUser ? .white : Color(.systemBlue))
                    .foregroundColor(user.isCurrentUser ? .black : .white)
                    .cornerRadius(6)
                    .overlay(RoundedRectangle(cornerRadius: 6)
                        .stroke(user.isCurrentUser ? .gray: .clear, lineWidth: 1))
            }
            
            Divider()
        }.fullScreenCover(isPresented: $showEditProfile) {
          EditProfileView(user: user)
        }
    }
}

struct ProfileHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileHeaderView(user: User.MOCK_USERS[0])
    }
}
