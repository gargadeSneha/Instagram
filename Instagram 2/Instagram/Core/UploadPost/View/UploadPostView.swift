//
//  UploadPostView.swift
//  Instagram
//
//  Created by Sneha Gargade on 28/08/23.
//

import SwiftUI
import PhotosUI
import AVKit

struct UploadPostView: View {
    @State private var caption = ""
    @State private var imagePickerPresented = false
//    @State private var PhotoItem: PhotosPickerItem?
    @StateObject  var viewModel = UploadPostViewModel()
    @Binding var tabIndex: Int
    
    var body: some View {
        VStack{
            //action tool bar
            HStack{
                Button {
                    clearPostDataAndReturnToFeed()
                } label: {
                    Text("Cancel")
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Text("New Post")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task{
                        try await viewModel.uploadPost(caption: caption)
                        clearPostDataAndReturnToFeed()
                    }
                } label: {
                    Text("Upload")
                        .fontWeight(.semibold)
                }
            }.padding(.horizontal)
            
            //post image and caption
            HStack(spacing: 8){
                if let image = viewModel.postImage{
                    image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
                    
                }
//                else if let newVideo = viewModel.postVideo {
//                   let _ =  print("newVideo: ", newVideo)
//                   
//                        VideoPlayer(player: AVPlayer(url: newVideo))
//                        .scaledToFill()
//                        .frame(width: 100, height: 100)
//                        .clipped()
//                               
//                }
                
                TextField("Enter your caption...", text: $caption, axis: .vertical)
            }.padding()
            
            Spacer()
        }
        .onAppear{
            imagePickerPresented.toggle()
        }
        .photosPicker(isPresented: $imagePickerPresented, selection: $viewModel.selectedItem, matching: .any(of: [.images, .videos]), photoLibrary: .shared())

    }
    
    func clearPostDataAndReturnToFeed() {
        caption = ""
        viewModel.selectedItem = nil
        viewModel.postImage = nil
        tabIndex = 0
    }
}

struct UploadPostView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPostView( tabIndex: .constant(0))
    }
}
