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
  let editProfileVc = EditProfileController(nibName: nil, bundle: nil)
  
  
  //Outlets
  @IBOutlet weak var last: UILabel!
  @IBOutlet weak var first: UILabel!
  @IBOutlet weak var email: UILabel!
  @IBOutlet weak var picture: UIImageView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchData()
  }
  
  func fetchData(){
    DispatchQueue.global(qos: .userInteractive).async{
      DatabaseService.shared.ref.observe(DataEventType.value, with:{(snapshot) in
        print(snapshot)
        guard let snap = UserSnapshot(with: snapshot) else {return }
        DispatchQueue.main.async {
          self.users = snap.users
          self.displayUser(from: self.users)}
      })}
  }


func displayUser(from  db: [User]){
  for user in db{
    if user.stamp == stamp {
      self.last.text = user.lastName
      self.first.text = user.firstName
      self.email.text = user.email
      
      let profilePictureUrl = URL(string: user.profilePicture)
      let data = try? Data(contentsOf: profilePictureUrl!)
      
      if let imageData = data {
        
        self.picture.image = UIImage(data: imageData)
      }
    }
    
  }
}
  @IBAction func editProfile(_ sender: Any) {
    editProfileVc.stamp = stamp
    present(editProfileVc, animated:  true, completion: nil)
  }
}


