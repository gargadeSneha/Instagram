//
//  SearchViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 30/08/23.
//
//MARK:  fetchAllUsers() of this file calls the UserServices fetchAllUsers func, then automaticall we sets the users variable which is published which is update our view

import Foundation

class searchViewModel: ObservableObject{
    @Published var users = [User]()
    
    init() {
        Task{ try await fetchAllUsers() }
    }
    
    @MainActor 
    func fetchAllUsers() async throws {
         self.users = try await UserService.fetchAllUser()
    }
}
