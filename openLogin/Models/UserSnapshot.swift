//
//  UserSnapshot.swift
//  openLogin
//
//  Created by Mathieu Janneau on 07/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import Firebase

struct UserSnapshot{
  
  let users: [User]
  
  init?(with snapshot: DataSnapshot){
    
    var userArray = [User]()
    guard let snapDict = snapshot.value as? [String: [String: Any]] else{return nil}
    for snap in snapDict {
      guard let user = User(userId: snap.key,dict: snap.value) else {continue}
      userArray.append(user)
    }
    self.users = userArray
  }
  
}
