//
//  CreateAccountController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 06/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import Firebase

class CreateAccountController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
  let profileVc = ProfileViewController(nibName: nil, bundle: nil)
  //Initialize the Picker
  let image = UIImagePickerController()
  var ref: DatabaseReference!
  
  var profilePictureName : String?
  override func viewDidLoad() {
    super.viewDidLoad()
    image.delegate = self
    image.allowsEditing = false
    ref = Database.database().reference()
  }
  
  @IBOutlet weak var profilePicture: UIImageView!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var createButton: UIButton!
  
  @IBOutlet weak var addProfileImagePicture: UIButton!
  @IBOutlet weak var confirmPassword: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var firstName: UITextField!
  
  
  @IBAction func addProfilePicture(_ sender: Any) {
    ImportImageFromAlbum(image)
  }
  
  @IBAction func CreateAccount(_ sender: Any) {
    // use guards??
    if lastName.text != nil && firstName.text != nil && email.text != nil && password.text != nil && confirmPassword.text != nil {
      let data = UIImagePNGRepresentation(profilePicture.image!) as NSData?
      let dataAsString = String(describing: data!)
      print(dataAsString)
      
      let userToCreate = ["lastName" : lastName.text!,"firstName" : firstName.text!,"email" : email.text!,"password" : password.text!,"stamp": String(Int(Date.timeIntervalSinceReferenceDate * 1000)),"profilePicture": dataAsString]
      
      //Send user to Firebase
      DatabaseService.shared.ref.childByAutoId().setValue(userToCreate)
      // send user's stamp to profileVc to retrieve the user
      profileVc.stamp = userToCreate["stamp"]!
      
      navigationController?.pushViewController(profileVc, animated: true)
      //      if let data = UIImagePNGRepresentation(profilePicture.image!) as NSData?
      
    }
  }
  
  /**
   Method to instantiate the UIImagePickerController
   You can allow editing by switching it to @true
   - parameters:
   - image: UIImagePickerController
   */
  private func ImportImageFromAlbum(_ image: UIImagePickerController){
    self.image.sourceType = UIImagePickerControllerSourceType.photoLibrary
    self.present(image, animated: true, completion: nil)
  }
  
  
  
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
    {
      profilePicture.image = image
      self.dismiss(animated: true, completion: nil)
    }
  }
}



