//
//  PostGridView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI
import Kingfisher

struct PostGridView: View {
    
    @StateObject var viewModel: PostGridViewModel
    
    init(user: User){
        self._viewModel = StateObject(wrappedValue: PostGridViewModel(user: user))
    }
    
    private let gridItem: [GridItem] = [
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1),
        .init(.flexible(), spacing: 1)
    ]
    
    private let imageDimentions:  CGFloat = (UIScreen.main.bounds.width / 3) - 1
    
    var body: some View {
        LazyVGrid(columns: gridItem, spacing: 1) {
            ForEach(viewModel.posts){ post in
//                Image(post.imageUrl!)
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimentions, height: imageDimentions)
                    .clipped()
            }
        }
//        Text("f")
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView(user: User.MOCK_USERS[0])
    }
}
