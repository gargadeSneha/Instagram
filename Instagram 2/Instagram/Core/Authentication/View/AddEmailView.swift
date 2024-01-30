//
//  AddEmailView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI

struct AddEmailView: View {
//    @State private var email = ""
    @Environment (\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistationViewModel
    
    var body: some View {
        VStack(spacing: 12){
            Text("Add your email")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
            
            Text("You'll use this email tosign in to your account")
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 24)
            
            TextField("email", text: $viewModel.email)
                .autocapitalization(.none)
                .modifier(IGTextFieldModifier())
                .padding(.top)
            
            NavigationLink {
                CreateUserNameView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 360, height: 44)
                    .background(Color(.systemBlue))
                    .cornerRadius(8)
            }.padding(.vertical)

            
            Spacer()
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

struct AddEmailView_Previews: PreviewProvider {
    static var previews: some View {
        AddEmailView()
    }
}
