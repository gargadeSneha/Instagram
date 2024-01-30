//
//  EditProfileViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 30/08/23.
//

import Foundation
import Firebase
import SwiftUI
import PhotosUI

class EditProfileViewModel: ObservableObject{
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet{
            Task {await loadImage(fromItem: selectedImage)}
        }
    }
    
    @Published var ProfileImage: Image?
    @Published  var fullname = ""
    @Published  var bio = ""
    
     private var uiImage: UIImage?
    
    init(user: User){
        self.user = user
        
        if let fullname = user.fullName {
            self.fullname = fullname
        }
        
        if let bio = user.bio {
            self.bio = bio
        }
    }
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
        self.uiImage = uiImage
        self.ProfileImage = Image(uiImage: uiImage)
    }
    
    func updateUserData() async throws {
        //update profile pic if changed
        
        
        var data = [String: Any]()
        
        if let uiImage = uiImage{
           let imageUrl = try await ImageUploaders.uploadImage(image: uiImage)
            data["profileImageUrl"] = imageUrl
        }
        
        //update name if changed
        if !fullname.isEmpty && user.fullName != fullname {
//            print("Update fullname: \(fullname)")
//            user.fullName = fullname
            data["fullName"] = fullname
        }
        
        //update bio if changed
        if !bio.isEmpty && user.bio != bio {
//            print("Update bio: \(bio)")
//            user.bio = bio
            data["bio"] = bio
        }
        if !data.isEmpty {
            try await Firestore.firestore().collection("users").document(user.id).updateData(data)
        }
    }
}

