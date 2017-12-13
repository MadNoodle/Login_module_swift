//
//  ForgotPassword.swift
//  openLogin
//
//  Created by Mathieu Janneau on 05/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

class ForgotPassword: UIViewController {
  
  // MARK: OUTLETS
  @IBOutlet weak var enterEmail: UITextField!
  @IBOutlet weak var askForPassword: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // MARK: ACTTIONS
  @IBAction func resetPassword(_ sender: Any) {
    print(enterEmail.text!)
  }
  
}
