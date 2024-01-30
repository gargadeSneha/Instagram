//
//  RegistrationViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 29/08/23.
//

import Foundation

class RegistationViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""

    func createUser() async throws {
        try await AuthService.shared.createUser(email: email, password: password, username: username)
        
        username = ""
        email = ""
        password = ""
    }
}
