//
//  ImageUploaders.swift
//  Instagram
//
//  Created by Sneha Gargade on 01/09/23.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

struct ImageUploaders {
    static func uploadImage(image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {return nil}
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_image/\(filename)")
        
        do{
            let _ =  try await ref.putDataAsync(imageData)
            let url =  try await ref.downloadURL()
            return url.absoluteString
        } catch{
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    static func uploadVideo(withData videoData: Data) async throws -> String? {
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference().child("/post_video/\(filename)")
        
        let metadata = StorageMetadata()
        metadata.contentType = "video/mp4"
        
        do{
            let _ =  try await ref.putDataAsync(videoData, metadata: metadata)
            let url =  try await ref.downloadURL()
            return url.absoluteString
        } catch{
            print("error: \(error.localizedDescription)")
            return nil
        }
    }
    
    
}
