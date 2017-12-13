//
//  FacebookRequest.swift
//  openLogin
//
//  Created by Mathieu Janneau on 07/12/2017.
//  Copyright © 2017 Mathieu Janneau. All rights reserved.
//

import Foundation
import FacebookCore

struct FacebookRequest: GraphRequestProtocol {
  var graphPath: String
  var parameters: [String : Any]?
  var accessToken: AccessToken?
  var httpMethod: GraphRequestHTTPMethod
  var apiVersion: GraphAPIVersion
  
  struct Response: GraphResponseProtocol {
    init(rawResponse: Any?) {
    }
    
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
  }
}
