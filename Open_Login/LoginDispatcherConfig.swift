//
//  LoginDispatcherConfig.swift
//  Open_Login
//
//  Created by Mathieu Janneau on 04/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

class LoginDispatcher {
  // MARK: - Properties
  
  public var window: UIWindow?

  public var rootViewController: UIViewController?
  
 private static let bundle = Bundle(for: LoginController.self)
  
  
  public init(rootViewController: UIViewController) {
    self.rootViewController = rootViewController
    self.window = nil
  }
  
  public init(window: UIWindow) {
    self.window = window
    self.rootViewController = nil
  }
  
  
  // Initialization Navigavtion Controller
  fileprivate var navigationController: UINavigationController {
    if _navigationController == nil {
      _navigationController = UINavigationController(rootViewController: self.initialViewController)
    }
    return _navigationController!
  }
  private var _navigationController: UINavigationController?
  
    // Initialization First Controller
  fileprivate var initialViewController: LoginController {
    if _initialViewController == nil {
      let viewController = LoginController()
//      viewController.delegate = self
      
      _initialViewController = viewController
    }
    return _initialViewController!
  }
  fileprivate var _initialViewController: LoginController?
  
  open func start() {
    if let rootViewController = rootViewController {
      rootViewController.present(navigationController, animated: true, completion: nil)
    } else if let window = window {
      window.rootViewController = navigationController
      window.makeKeyAndVisible()
    }
  }
  
  public func visibleViewController() -> UIViewController? {
    return navigationController.topViewController
  }
}

// extension LoginDispatcher: LoginControllerDelegate {
//  func userDidSelectCreate(_ viewController: UIViewController) {
//
//  }
//
//  func userDidSelectSignIn(_ viewController: UIViewController) {
//
//  }
//
//  func userDidSelectFacebook(_ viewController: UIViewController) {
//
//  }
//
//}

extension SignInController: SignInDelegate{
  func didEnterLogin() {
    
  }
  
  func didEnterPassword() {
    
  }
  
  func didSelectForgot() {
    
  }
  
  func didSelectSignIn() {
    
  }
  
  
  
}

public extension UIViewController {
  
  func viewFromNib() -> UIView {
    let name = String(describing: type(of: self))
    let bundle = Bundle(for: type(of: self))
    guard let view = bundle.loadNibNamed(name, owner: self, options: nil)?.first as? UIView else {
      fatalError("Nib not found.")
    }
    return view
  }
  
}
