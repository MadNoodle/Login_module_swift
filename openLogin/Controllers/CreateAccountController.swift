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
  let profileVc = ProfileViewController(nibName: nil, bundle: nil)
  //Initialize the Picker
  let image = UIImagePickerController()
  var ref: DatabaseReference!
  // Get a reference to the storage service using the default Firebase App
  let storage = Storage.storage()
  
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
      let uuid = UUID().uuidString
      let compressedSize = CGSize(width: 500.0, height: 500.0)
      let resizedProfilePicture = ResizeImage(image: profilePicture.image!, targetSize: compressedSize)
      let data = UIImagePNGRepresentation(resizedProfilePicture) as Data?
      // Create a storage reference from our storage service
      let storageRef = storage.reference()
      let imageRef = storageRef.child("\(uuid).jpg")
      
      DispatchQueue.global(qos: .userInteractive).async{
      // Upload the file to the path "images/rivers.jpg"
      let uploadTask = imageRef.putData(data!, metadata: nil) { (metadata, error) in
        guard let metadata = metadata else {
          // Uh-oh, an error occurred!
          return
        }
        // Metadata contains file metadata such as size, content-type, and download URL.
        let downloadURL = metadata.downloadURL
        
        if let profileImageUrl =  metadata.downloadURL()?.absoluteString{
          self.registerUser(url: profileImageUrl)
        }
      }
      }
      navigationController?.pushViewController(profileVc, animated: true)
      
      
    }
  }
  
  private func registerUser(url:String){
    
    let userToCreate = ["lastName" : lastName.text!,"firstName" : firstName.text!,"email" : email.text!,"password" : password.text!,"stamp": String(Int(Date.timeIntervalSinceReferenceDate * 1000)),"profilePicture":url ]
    
    //Send user to Firebase
    DatabaseService.shared.ref.childByAutoId().setValue(userToCreate)
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
  
  func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
      newSize = CGSize(width: size.width * heightRatio,height: size.height * heightRatio)
    } else {
      newSize = CGSize(width: size.width * widthRatio,height:  size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0,y: 0,width: newSize.width,height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}



