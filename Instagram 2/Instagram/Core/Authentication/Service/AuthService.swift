//
//  AuthService.swift
//  Instagram
//
//  Created by Sneha Gargade on 29/08/23.
//

//MARK: For Authentication
//  First we start with AuthSerivce file = It initilizes usersession it could be nill or could have a value
// AuthService is linked with ContentViewModel. The ContentViewModel is subscribes to the AuthSerivce and the @Publish property is part of it



import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestoreSwift

class AuthService {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var curentUser: User?
    
    static let shared = AuthService()
    
    init() {
        Task{
            try await loadUserData()
        }
    }
    
    @MainActor
    func login(withEmail email: String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            try await loadUserData()
        }catch{
            print("Fail to login due to:  \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
//        print("Email is: \(email)")
//        print("password is: \(password)")
//        print("username is: \(username)")
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
//            print("Create user...")
            await uploadUserData(uid: result.user.uid, username: username, email: email)
//            print("Upload user data...")
        }catch{
            print("Fail to register due to : \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func loadUserData() async throws {
        self.userSession = Auth.auth().currentUser
        guard let currentUid = userSession?.uid else { return }
//        let snapShot = try await Firestore.firestore().collection("users").document(currentUid).getDocument()
////        print("snapShot data is \(snapShot.data())")
//        self.curentUser = try? snapShot.data(as: User.self) // decoding data
        self.curentUser = try await UserService.fetchUser(withUid: currentUid )
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
        self.curentUser = nil
    }
    
    private  func uploadUserData(uid: String, username: String, email: String) async {
        let user = User(id: uid, username: username, email: email)
        self.curentUser = user
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return } //Encoding data
        
        try? await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
    }
}
