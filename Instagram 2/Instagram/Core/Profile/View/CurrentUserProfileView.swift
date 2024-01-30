//
//  CurrentUserProfileView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user: User
    
//    var posts: [Post] {
//        return Post.MOCK_POST.filter({$0.user?.username == user.username})
//    }
    
    var body: some View {
        NavigationStack {
            ScrollView{
                //header
                ProfileHeaderView(user: user)
                
                //post grid view
              PostGridView(user: user)
                
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    AuthService.shared.signOut()
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.black)
                }

        }
        }
    }
}

struct CurrentUserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentUserProfileView(user: User.MOCK_USERS[0])
    }
}
