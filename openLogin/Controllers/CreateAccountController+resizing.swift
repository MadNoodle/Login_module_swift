//
//  CreateAccountController+resizing.swift
//  openLogin
//
//  Created by Mathieu Janneau on 13/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit
/**
 UIImage extension needed in ProfilViewController
 */
extension UIImage {
  
  /**
   Function that resize profile picture in a certain Size
   - parameters:
      - targetSize: CGSize final size of the image
   
   - returns: UIImage
 */
  func ResizeImage( targetSize: CGSize) -> UIImage {
    let size = self.size
    
    let widthRatio  = targetSize.width  / self.size.width
    let heightRatio = targetSize.height / self.size.height
    
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
    self.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
  }
}
