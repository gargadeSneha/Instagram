//
//  CompleteSignUpView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI

struct CompleteSignUpView: View {
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistationViewModel
    
    var body: some View {
        VStack(spacing: 12){
            Text("Welcome to Instagram, \(viewModel.username)")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Click below to complete registration and start useing Instagram")
                .font(.footnote)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            Button {
                Task{
                    try await viewModel.createUser()
                }
            } label: {
                Text("Complete Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }.padding(.vertical)

        }.toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
            }
        }
    }
}

struct CompleteSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        CompleteSignUpView()
    }
}
