//
//  ViewController.swift
//  Open_Login
//
//  Created by Mathieu Janneau on 04/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit

protocol LoginControllerDelegate: class {
  
  func userDidSelectCreate(_ viewController: UIViewController)
  func userDidSelectSignIn(_ viewController: UIViewController)
  func userDidSelectFacebook(_ viewController: UIViewController)
}

class LoginController: UIViewController {
  
  //Properties
  var delegate: LoginControllerDelegate?

  //Outlets
  @IBOutlet weak var createButton: UIButton!
  @IBOutlet weak var signInButton: UIButton!
  @IBOutlet weak var fbLoginButton: UIButton!
  @IBOutlet weak var backrgoundImage: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  
  @IBAction func userDidSelectCreate(_ sender: AnyObject) {
    delegate?.userDidSelectCreate(self)
  }
  
  @IBAction func userDidSelectSignIn(_ sender: AnyObject) {
    delegate?.userDidSelectSignIn(self)
  }
  
  @IBAction func userDidSelectFacebook(_ sender: AnyObject) {
    delegate?.userDidSelectFacebook(self)
  }
  
}

