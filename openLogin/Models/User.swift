//
//  User.swift
//  openLogin
//
//  Created by Mathieu Janneau on 06/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation

class User {
  let userId: String
  let stamp: String
  let lastName : String
  let firstName : String
  let email: String
  let password: String
  let profilePicture: String
  
  init?(userId: String ,dict: [String:Any]){
    self.userId = userId
    guard let lastName = dict["lastName"] as? String,
      let firstName = dict["firstName"] as? String,
      let email = dict["email"] as? String,
      let password = dict["password"] as? String,
      let stamp = dict["stamp"] as? String,
      let profilePicture = dict["profilePicture"] as? String
      else {return nil}
    
    
    self.stamp = stamp
    self.lastName = lastName
    self.firstName = firstName
    self.email = email
    self.password = password
    self.profilePicture = profilePicture
    
//    self.imageName = imageName
//    self.data = data
  }
  
}

  

