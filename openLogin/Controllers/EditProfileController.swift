//
//  EditProfileController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 13/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class EditProfileController: UIViewController {
  
  // MARK: PROPERTIES
  var users = [User]()
  var stamp:String?
  // Get a reference to the storage service using the default Firebase App
  let storage = Storage.storage()
  // MARK: OUTLETS
  @IBOutlet weak var profilePicture: UIImageView!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var firstName: UITextField!
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var confirmPassword: UITextField!
  
  // MARK: LIFECYCLE METHODS
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: ACTIONS
  @IBAction func updateProfile(_ sender: Any) {
    if lastName.text != nil && firstName.text != nil && email.text != nil && password.text != nil && confirmPassword.text != nil {
      let uuid = UUID().uuidString
      let compressedSize = CGSize(width: 500.0, height: 500.0)
      let resizedProfilePicture = profilePicture.image!.ResizeImage( targetSize: compressedSize)
      uploadUpdates(resizedProfilePicture, uuid)
      
    }
  }
  
  /**
   Update existing profile by sending changed infos
 */
  func uploadUpdates(_ resizedProfilePicture: UIImage, _ uuid: String) {
    let data = UIImagePNGRepresentation(resizedProfilePicture) as Data?
    // Create a storage reference from our storage service
    let storageRef = storage.reference()
    let imageRef = storageRef.child("\(uuid).jpg")
    
    DispatchQueue.global(qos: .userInteractive).async{
      // Upload the file to the path "images/rivers.jpg"
      _ = imageRef.putData(data!, metadata: nil) { (metadata, error) in
        guard let metadata = metadata else {
          print("error while uploading data")
          return
        }
        if let profileImageUrl =  metadata.downloadURL()?.absoluteString{
          self.updateUser(self.stamp!, with: profileImageUrl)
        }
      }
    }
  }
  
  /**
   Upload the new values on firebase database
 */
  func updateUser(_ stamp:String, with image:String){
    let newValues = ["lastName" : lastName.text!,"firstName" : firstName.text!,"email" : email.text!,"password" : password.text!,"stamp": stamp,"profilePicture":image ]
    DatabaseService.shared.ref.child(stamp).setValue(newValues)
  }
}

