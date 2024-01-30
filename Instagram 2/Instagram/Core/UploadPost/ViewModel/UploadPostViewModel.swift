//
//  UploadPostViewModel.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import Foundation
import SwiftUI
import PhotosUI
import Firebase
import FirebaseStorage
import AVKit

struct Movie: Transferable {
    let url: URL

    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.url)
        } importing: { received in
            let copy = URL.documentsDirectory.appending(path: "movie.mp4")
//                print("-->",copy)
            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: received.file, to: copy)
            return Self.init(url: copy)
        }
    }
}

class UploadPostViewModel: ObservableObject{
    enum LoadState {
        case unknown, loading, loadedMovie(Movie), failed
    }
    @Published  var selectedImageData: Data?
    @Published  var loadState = LoadState.unknown
    
    @Published var selectedItem: PhotosPickerItem? {
        didSet{
            Task {
                await loadImage(fromItem: selectedItem)
//                await uploadVideo(fromItem: selectedItem)
            }
        }
    }
    
    @Published var postImage: Image?
    private var uiImage: UIImage?
    private var videoUrl: URL?
    @Published var postVideo: URL?
    
    
    @MainActor
    func loadImage(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
        guard let data = try? await item.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: data) else { return }
//        print("--/>", uiImage)
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    @MainActor
    func uploadVideo(fromItem item: PhotosPickerItem?) async {
        guard let item = item else { return }
//        print("item: ",item.itemIdentifier)
        
        guard let videoData = try? await selectedItem?.loadTransferable(type: Movie.self) else { return }
        
//        print(videoData)
        self.videoUrl = URL(string: "\(videoData.url)")
        self.postVideo = videoUrl
        let data1 = NSData(contentsOf: videoData.url)
        print(data1!)
        
//      print("Data is: \(videoData)")
//        let data = NSData(contentsOf: videoData as URL)
//        guard let videoUrl = try? await ImageUploaders.uploadVideo(withData: data1 as! Data) else { return }
//        self.videoUrl = videoUrl
//        try? await Firestore.firestore().collection("post").document().setData(["videoUrl" : videoUrl])
      
    }
    
    func uploadPost(caption: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let uiImage = uiImage else { return }
//        guard let videoUrl = videoUrl else { return }
        
        let postRef = Firestore.firestore().collection("post").document()
        guard let imageUrl = try await ImageUploaders.uploadImage(image: uiImage) else { return }
        
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timeStamp: Timestamp(), user: nil)
        
        guard let encodedPost = try? Firestore.Encoder().encode(post) else {return}
        
        try await postRef.setData(encodedPost)
        
    }
    
 
    
}
