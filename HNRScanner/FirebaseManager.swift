//
//  FirebaseManager.swift
//  HNRScanner
//
//  Created by Deshun Cai on 11/5/18.
//  Copyright © 2018 NUS Hackers. All rights reserved.
//

import Foundation
import Firebase

enum RegistrationOutcome {
    case SuccessfullyRegistered
    case AlreadyRegistered
    case UserDoesNotExist
}


class FirebaseManager {
    
    static let sharedInstance = FirebaseManager()
    let db = Firestore.firestore()
    
    private init(){}
    
    static func getInstance() -> FirebaseManager {
        return sharedInstance
    }
    
    func register(user : String, completion: @escaping (RegistrationOutcome) -> ()) {
        let docRef = db.collection("users").document(user)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let hasPhysicallyRegistered : Bool = document.data()?["physicallyRegistered"] as? Bool ?? false
                if hasPhysicallyRegistered {
                    completion(RegistrationOutcome.AlreadyRegistered)
                } else {
                    docRef.updateData(["physicallyRegistered" : true]) { err in
                        if let err = err {
                            print("Error updating document: \(err)")
                        } else {
                            completion(RegistrationOutcome.SuccessfullyRegistered)
                        }
                    }
                }
                
            } else {
                completion(RegistrationOutcome.UserDoesNotExist)
            }
        }
    }
}
