//
//  ForgotPassword.swift
//  openLogin
//
//  Created by Mathieu Janneau on 05/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import Validator
class ForgotPassword: UIViewController {
  
  // MARK: OUTLETS
  @IBOutlet weak var enterEmail: UITextField!
  @IBOutlet weak var askForPassword: UIButton!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    }
  
  // MARK: ACTTIONS
  @IBAction func resetPassword(_ sender: Any) {
    let result = setupValidation()
    switch result {
    case .valid:
      print(enterEmail.text!)
    case .invalid:
      print("please enter a valid email address")
    }
    
  }
  
  func setupValidation() -> ValidationResult{
    
    let emailRule = ValidationRulePattern(pattern: EmailValidationPattern.standard, error: ValidationError(message: "please enter a valid email address"))
    let result = enterEmail.validate(rule:emailRule)
    return result
  }
}
