//
//  LoginDispatcher.swift
//  openLogin
//
//  Created by Mathieu Janneau on 05/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import Firebase




class DatabaseService {
 
  static let shared = DatabaseService()
  private init(){}
 
 let ref = Database.database().reference().child("users")
}


