//
//  SignUpController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 05/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SignUpController: UIViewController {
  
  // MARK: PROPERTIES
  let profilVc = ProfileViewController(nibName: nil, bundle: nil)
  let createVc = CreateAccountController(nibName: nil, bundle: nil)
  let forgotVc = ForgotPassword(nibName: nil, bundle: nil)
  var users = [User]()
  
  // MARK: OUTLETS
  @IBOutlet weak var enterLogin: UITextField!
  @IBOutlet weak var enterPassword: UITextField!
  @IBOutlet weak var forgotPassword: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: ACTIONS
  
  @IBAction func signUp(_ sender: Any) {
    verifyUser()
  }
  
  @IBAction func forgotPassword(_ sender: Any) {
    navigationController?.pushViewController(forgotVc, animated: true)
  }
  
  /**
   Connect to Firebase Database and send results from bg thread to main thread
   */
  func verifyUser(){
    // Make the request on background thread
    DispatchQueue.global(qos: .userInteractive).async{
      DatabaseService.shared.ref.observe(DataEventType.value, with:{(snapshot) in
        guard let snap = UserSnapshot(with: snapshot) else {return }
        //Send the results in a snapshot on main thread
        DispatchQueue.main.async {
          self.users = snap.users
          self.checkCredential(for : self.users)
        }
      })}
  }
  /**
   Function that verifies if the login exists in the database and if it exist check if the password is valid
   - parameters:
   - users: [User] Database
   */
  func checkCredential(for users : [User]){
    for user in users {
      if self.enterLogin.text != user.email {
 self.navigationController?.pushViewController(self.createVc, animated: true)
      } else{
        if self.enterPassword.text == user.password {
          self.profilVc.stamp = user.stamp
          self.navigationController?.pushViewController(self.profilVc, animated: true)
        }
        else {
          self.popAlert(message: "password and login do not match", callToAction: "Try Again" )
        }
      }
    }
  }
  
/**
   Function that pops an Alert and dismiss the alert Controller
   - parameters:
       - message: String header message
       - callToAction: String button message
 */
  func popAlert(message: String, callToAction: String){
    let cancelAction = UIAlertAction(title: callToAction,style: .cancel)
    let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
    alert.addAction(cancelAction)
    self.present(alert,animated: true)
  }
}
