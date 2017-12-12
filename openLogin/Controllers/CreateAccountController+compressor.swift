//
//  CreateAccountController+compressor.swift
//  openLogin
//
//  Created by Mathieu Janneau on 12/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
  
  
  func resizeByByte(maxByte: Int) {
    
    var compressQuality: CGFloat = 1
    var imageByte = UIImageJPEGRepresentation(self, 1)?.count
    
    while imageByte! > maxByte {
      
      imageByte = UIImageJPEGRepresentation(self, compressQuality)?.count
      compressQuality -= 0.1
    }
  }
}
