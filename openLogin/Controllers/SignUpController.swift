//
//  SignUpController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 05/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    let createVc = CreateAccountController(nibName:nil, bundle:nil)
  // MARK: OUTLETS
  @IBOutlet weak var enterLogin: UITextField!
  @IBOutlet weak var enterPassword: UITextField!
  @IBOutlet weak var forgotPassword: UIButton!

  
  override func viewDidLoad() {
        super.viewDidLoad()

    }
  
  // MARK: ACTIONS
  @IBAction func resetPassword(_ sender: Any) {
  }


  @IBAction func signUp(_ sender: Any) {
  
    
  }
  
}
