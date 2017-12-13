//
//  CreateAccountController.swift
//  openLogin
//
//  Created by Mathieu Janneau on 06/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class CreateAccountController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
  
  // MARK: PROPERTIES
  let profileVc = ProfileViewController(nibName: nil, bundle: nil)
  //Initialize the Picker
  let image = UIImagePickerController()
  // Get a reference to the database service using the default Firebase App
  var ref: DatabaseReference!
  // Get a reference to the storage service using the default Firebase App
  let storage = Storage.storage()
  
  
  // MARK: OUTLETS
  @IBOutlet weak var profilePicture: UIImageView!
  @IBOutlet weak var lastName: UITextField!
  @IBOutlet weak var createButton: UIButton!
  @IBOutlet weak var addProfileImagePicture: UIButton!
  @IBOutlet weak var confirmPassword: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var firstName: UITextField!
  
  // MARK: LIFECYCLE METHODS
  override func viewDidLoad() {
    super.viewDidLoad()
    image.delegate = self
    image.allowsEditing = false
    ref = Database.database().reference()
  }
  
  // MARK: ACTIONS
  
  @IBAction func addProfilePicture(_ sender: Any) {
    ImportImageFromAlbum(image)
  }
  
  
  @IBAction func CreateAccount(_ sender: Any) {
    if lastName.text != nil && firstName.text != nil && email.text != nil && password.text != nil && confirmPassword.text != nil {
      // give a unique id
      let uuid = UUID().uuidString
      // Size you wish to compress profile picture
      let compressedSize = CGSize(width: 500.0, height: 500.0)
      // actual resizing
      let resizedProfilePicture = profilePicture.image!.ResizeImage( targetSize: compressedSize)
      //upload image
      uploadImageToFirebase(resizedProfilePicture, uuid)
      // push profilVc
      navigationController?.pushViewController(profileVc, animated: true)
    }
  }
  
  /**
   Create user and send it to Firebase
   grab the url from Firebase Storage to String and inject it in the database
   - parameters:
   - url: String Storage url for uploaded profile Image
   */
  private func registerUserIntoDatabse(with url:String){
    let stamp = String(Int(Date.timeIntervalSinceReferenceDate * 1000))
    // Conform data in a model instance
    let userToCreate = ["lastName" : lastName.text!,"firstName" : firstName.text!,"email" : email.text!,"password" : password.text!,"stamp": stamp,"profilePicture":url ]
    
    //Send user to Firebase
    DatabaseService.shared.ref.child(stamp).setValue(userToCreate)
    // send user's stamp to profileVc to retrieve the user
    profileVc.stamp = userToCreate["stamp"]!
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
  
  /**
   Upload the image to Firebase Storage
   - parameters:
   - resizedPRofilePicture: UIImage compressed image to upload
   - uuid: unique id
   */
  func uploadImageToFirebase(_ resizedProfilePicture: UIImage, _ uuid: String) {
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
          self.registerUserIntoDatabse(with: profileImageUrl)
        }
      }
    }
  }
  
}


