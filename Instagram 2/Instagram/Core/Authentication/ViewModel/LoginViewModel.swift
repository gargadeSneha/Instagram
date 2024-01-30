//
//  LoginViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 29/08/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws {
       try await AuthService.shared.login(withEmail: email, password: password)
    }
}
