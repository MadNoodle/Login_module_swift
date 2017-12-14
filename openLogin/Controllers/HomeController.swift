//
//  HomerController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 05/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import Firebase


class HomeController: UIViewController {
  //MARK: PROPERTIES
  
  let signVc = SignUpController(nibName: nil, bundle: nil)
  let createVc = CreateAccountController(nibName:nil, bundle:nil)
  let profilVc = ProfileViewController(nibName: nil,bundle:nil)
  var users = [User]()
  var ref: DatabaseReference!
  //MARK: OUTLETS
  @IBOutlet weak var stackView: UIStackView!
  @IBOutlet weak var create: UIButton!
  @IBOutlet weak var signUp: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupFbButton()
    ref = Database.database().reference()
    // Token for fb login
    if let token = AccessToken.current{
      /// ToDo: check if already logged
      print("access")
    }
  }
  
  // MARK: ACTIONS
  @IBAction func createAccount(_ sender: Any) {
    navigationController?.pushViewController(createVc, animated: true)
  }
  
  @IBAction func signUp(_ sender: Any) {
    navigationController?.pushViewController(signVc, animated: true)
  }
  /**
   Instantiate Fb Login button and add it in the stackView
   */
  func setupFbButton(){
    let myLoginButton = UIButton(type: .custom)
    myLoginButton.backgroundColor = #colorLiteral(red: 0.1327910721, green: 0.403090775, blue: 0.6064034104, alpha: 1)
    myLoginButton.frame = CGRect(x: 0,y: 0,width: 180,height: 50)
    myLoginButton.layer.cornerRadius = 5
    myLoginButton.center = view.center
    myLoginButton.setTitle("My Login Button", for: [])
    myLoginButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
    
    self.stackView.addArrangedSubview(myLoginButton)
  }
  
  /**
   CallBack function when FB button is pressed.
   */
  @objc func loginButtonClicked(){
    let loginManager = LoginManager()
    loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { loginResult in
      switch loginResult {
      case .failed(let error):
        print(error)
      case .cancelled:
        print("User cancelled login.")
      case .success:
        // data to pass to profile
        self.getDataFromFb()
        self.navigationController?.pushViewController(self.profilVc,animated:true)
        
      }
    }
  }
  
  /// Todo: A refactor dans fb service
  func getDataFromFb(){
    let connection = GraphRequestConnection()
    let parameters: [String : Any]? = ["fields": "id, name, email, picture.type(large)"]
    connection.add(GraphRequest(graphPath: "/me", parameters: parameters!)) { httpResponse, result in
      switch result {
      case .success(let response):
        print("Graph Request Succeeded: \(response)")
        let stamp = String(Int(Date.timeIntervalSinceReferenceDate * 1000))
        
        if let responseDictionary = response.dictionaryValue {
          let name = responseDictionary["name"] as? String
          let nameArray = name?.split(separator: " ")
          let lastName = String(nameArray![1])
          let firstName = String(nameArray![0])
          let email = responseDictionary["email"] as? String
          if let picture = responseDictionary["picture"] as? [String:Any]{
            let data = picture["data"]as? [String:Any]
            let url = data!["url"] as? String
            
            let userToCreate = ["lastName" : lastName,"firstName" : firstName,"email" : email,"password" : "","stamp": stamp,"profilePicture":url ]
            
            //Send user to Firebase
            DatabaseService.shared.ref.child(stamp).setValue(userToCreate)
            self.profilVc.stamp = stamp
          }
          
        }
        
      case .failed(let error):
        print("Graph Request Failed: \(error)")
      }
    }
    connection.start()
  }
  
  
//  /**
//   Create user and send it to Firebase
//   grab the url from Firebase Storage to String and inject it in the database
//   - parameters:
//   - url: String Storage url for uploaded profile Image
//   */
//  private func registerUserIntoDatabse(with url:String){
//    let stamp = String(Int(Date.timeIntervalSinceReferenceDate * 1000))
//    // Conform data in a model instance
//
//    // send user's stamp to profileVc to retrieve the user
//    profileVc.stamp = userToCreate["stamp"]!
//  }
  
  
  
}



