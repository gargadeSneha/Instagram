//
//  ContentView.swift
//  Instagram
//
//  Created by Sneha Gargade on 22/08/23.
//

//MARK: ContentView present view based on userSession that receivces from ContentViewModel througth @StateObject

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationModel = RegistationViewModel()
    
//    let currentUser: [String: Any]
    
    var body: some View {
        Group{
            if $viewModel.userSession == nil {
                //if we don't have login user
                LoginView()
                    .environmentObject(registrationModel)
            } else if let currentUser = viewModel.currentUser {
                //User already login
                MainTabView(user: currentUser)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
