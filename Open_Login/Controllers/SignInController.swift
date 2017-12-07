//
//  SignInControllerViewController.swift
//  Open_Login
//
//  Created by Mathieu Janneau on 04/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

protocol SignInDelegate{
  func didEnterLogin()
  func didEnterPassword()
  func didSelectForgot()
  func didSelectSignIn()
  
}
class SignInController: UIViewController {
  
  
  @IBOutlet weak var enterPassword: UITextField!
  @IBOutlet var enterLogin: UITextField!
  @IBOutlet weak var forgotPassword: UIButton!
  @IBOutlet weak var signIn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
