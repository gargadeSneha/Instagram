//
//  CircularProfileImageView.swift
//  Instagram
//
//  Created by Sneha Gargade on 04/09/23.
//

import SwiftUI
import Kingfisher

enum profileImageSize{
    case xsmall
    case small
    case medium
    case large
    
    var dimentions: CGFloat{
        switch self {
        case .xsmall:
            return 40
        case .small:
            return 48
        case .medium:
            return 64
        case .large:
            return 80
        }
    }
}

struct CircularProfileImageView: View {
    let user: User
    let size: profileImageSize
    
    var body: some View {

            if let imageUrl = user.profileImageUrl{
                KFImage(URL(string: imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: size.dimentions, height: size.dimentions)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: size.dimentions, height: size.dimentions)
                    .clipShape(Circle())
                    .foregroundColor(Color(.systemGray4))
            }

    }
}

struct CircularProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircularProfileImageView(user: User.MOCK_USERS[0], size: .large)
    }
}
