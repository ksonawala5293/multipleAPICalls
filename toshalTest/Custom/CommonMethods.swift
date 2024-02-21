//
//  CommonMethods.swift
//  toshalTest
//
//  Created by Jekil Patel on 21/02/24.
//

import Foundation
import UIKit

class CommonMethods {
    func getDeviceToken() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
