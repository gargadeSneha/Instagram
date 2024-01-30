//
//  LoginView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI

struct LoginView: View {
//    @State private var email = ""
//    @State private var password = ""
    @StateObject var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                
                Spacer()
                
                //Image logo
                Image("Insta_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 210, height: 100)
                
                //Text field for email and password
                VStack{
                    TextField("Enter your email", text: $viewModel.email)
                        .autocapitalization(.none)
                        .modifier(IGTextFieldModifier())
                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(IGTextFieldModifier())
                }
                
                Button {
                    print("Show forgot password")
                } label: {
                    Text("Forgot password?")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .padding(.top)
                        .padding(.trailing, 28)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                
                Button {
                    Task{
                        try await viewModel.signIn()
                    }
                } label: {
                    Text("Login")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 360, height: 44)
                        .background(Color(.systemBlue))
                        .cornerRadius(8)
                }.padding(.vertical)
                
                //Divider OR
                HStack{
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2 ) - 40,  height: 0.5)
                    
                    Text("OR")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2 ) - 40,  height: 0.5)
                }.foregroundColor(.gray)
                
                HStack{
                    Image("facebook-logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    
                    Text("Continue with facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.blue)
                }.padding(.top, 8)
                
                Spacer()
                
                Divider()
                
                NavigationLink{
                   AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account?")
                        
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                }
                .font(.footnote)
            }.padding(.vertical, 16)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
