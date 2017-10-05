//
//  DataService.swift
//  DevChat
//
//  Created by Gabriel T on 2017-10-05.
//  Copyright © 2017 Gabriel T. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    private static let _instance = DataService()
    
    static var instance: DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference {
        return Database.database().reference()
    }
    
    var usersRef: DatabaseReference {
        return mainRef.child(FIR_CHILD_USERS)
    }
    
    var mainStorageRef: StorageReference {
        return Storage.storage().reference(forURL: "gs://devchat-bcd3e.appspot.com")
    }
    
    var imagesStorageRef: StorageReference {
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: StorageReference {
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, Any> = [USER_FIRSTNAME: "", USER_LASTNAME: ""]
        mainRef.child(FIR_CHILD_USERS).child(uid).child(FIR_CHILD_PROFILE).setValue(profile)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User>, mediaURL: URL, textSnippet: String? = nil) {
        
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        
        var pr: Dictionary<String, Any> = ["mediaURL": mediaURL.absoluteString, "userID": senderUID, "openCount": 0, "recipients": uids]
        
        mainRef.child("pullRequests").childByAutoId().setValue(pr)
        
    }
}





















