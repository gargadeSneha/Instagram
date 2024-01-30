//
//  UserStackView.swift
//  Instagram
//
//  Created by Sneha Gargade on 23/08/23.
//

import SwiftUI

struct UserStackView: View {
    let value: Int
    let title: String
    var body: some View {
        VStack{
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }.frame(width: 76)
    }
}

struct UserStackView_Previews: PreviewProvider {
    static var previews: some View {
        UserStackView(value: 12, title: "Post")
    }
}
