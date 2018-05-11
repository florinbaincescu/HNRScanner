//
//  FirebaseManager.swift
//  HNRScanner
//
//  Created by Deshun Cai on 11/5/18.
//  Copyright © 2018 NUS Hackers. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let sharedInstance = FirebaseManager()
    
    private init(){}
    
    static func getInstance() -> FirebaseManager {
        return sharedInstance
    }
    
    func register(user : String) {
        
    }
}
