//
//  Connectivity.swift
//  toshalTest
//
//  Created by Jekil Patel on 21/02/24.
//

import Foundation
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

/*
if Connectivity.isConnectedToInternet {
     print("Connected")
 } else {
     print("No Internet")
}
*/
