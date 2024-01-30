//
//  ContentViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 29/08/23.
//

//MARK: recivecs userSession using combine
//Here we have setupSubscribers func  and it listens to the changes in userSession .sink func gives us the new value that we get back and  then we are able to set the value in userSession property here that coming back from AuthService.
// The ContentView is connected to ContentViewModel and it listening to changes in ContentViewModel. then ContentView receives the changes througth @StateObject then it show the result i.e. user is already login or not


import Foundation
import Firebase
import Combine

class ContentViewModel: ObservableObject {
    private let service = AuthService.shared
    private var cancellable = Set<AnyCancellable>()
    
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$userSession.sink { [weak self] userSession in
            self?.userSession = userSession
        }.store(in: &cancellable)
        
        service.$curentUser.sink { [weak self] currentUser in
            self?.currentUser = currentUser
        }.store(in: &cancellable)
    }
}
