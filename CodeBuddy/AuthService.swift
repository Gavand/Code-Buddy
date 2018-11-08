//
//  AuthService.swift
//  CodeBuddy
//
//  Created by Gavin Andrews on 10/31/18.
//  Copyright © 2018 Gavin Andrews. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class AuthService {
    
    static func login(email: String, password: String, onSuccess: @escaping ()->Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: { ( user, error) in
            if error != nil {
                
                return
            }
            onSuccess()
        })
        
    }
    static func signUp(username: String, email: String, password: String, dataImage: Data, onSuccess: @escaping ()->Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
            let uid = Auth.auth().currentUser!.uid
            let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOF_REF).child("profile_Image").child(uid)
            
            storageRef.putData(dataImage, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    return
                } else {
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil {
                            print(error!)
                            return
                        }
                        if url != nil {
                            setUserInformation(profileImageUrl: url!.absoluteString, username: username, email: email, uid: uid, onSuccess: onSuccess)
                        }
                        
                    })
                }
                // ...
            })
        })
        
    }
    static func setUserInformation(profileImageUrl: String, username: String, email: String, uid: String, onSuccess: @escaping ()->Void) {
        let ref = Database.database().reference()
        let usersRef = ref.child("users")
        let newUserRef = usersRef.child(uid)
        newUserRef.setValue(["username": username, "email": email, "profileImageURL": profileImageUrl])
        onSuccess()
    }
}
