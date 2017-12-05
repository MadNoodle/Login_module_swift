//
//  LoginDispatcherConfig.swift
//  Open_Login
//
//  Created by Mathieu Janneau on 04/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigSetup : class {
  
}

class LoginDispatcherConfig : ConfigSetup{
  
  private static let bundle = Bundle(for: LoginController.self)
  

}

extension LoginDispatcherConfig: LoginControllerDelegate {
  func userDidSelectCreate(_ viewController: UIViewController) {
    
  }
  
  func userDidSelectSignIn(_ viewController: UIViewController) {
    
  }
  
  func userDidSelectFacebook(_ viewController: UIViewController) {
    
  }
  
  
  
}
