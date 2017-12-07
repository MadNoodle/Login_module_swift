//
//  ProfileViewController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 07/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import Firebase
class ProfileViewController: UIViewController {
  
  //Properties
  var users = [User]()
  var stamp = ""
  
  
  //Outlets
  @IBOutlet weak var last: UILabel!
  @IBOutlet weak var first: UILabel!
  @IBOutlet weak var email: UILabel!
  @IBOutlet weak var profilePicture: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
      fetchData()
  }

  func fetchData(){
    DatabaseService.shared.ref.observe(DataEventType.value, with:{(snapshot) in
      print(snapshot)
      guard let snap = UserSnapshot(with: snapshot) else {return }
      self.users = snap.users
      self.displayUser(from: self.users)
    })
  }
  func displayUser(from  db: [User]){
    for user in db{
      if user.stamp == stamp {
        self.last.text = user.lastName
        self.first.text = user.firstName
        self.email.text = user.email
        let data = user.profilePicture.data(using: .utf8)
        self.profilePicture.image = UIImage(data: data!)
      }
    }
  }
  
}
