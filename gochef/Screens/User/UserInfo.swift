//
//  CurrentUser.swift
//  gochef
//
//  Created by Edson Rottava on 14/08/19.
//  Copyright © 2019 Edson Rottava. All rights reserved.
//

import UIKit

struct UserInfo {
    var userId: String = ""   // For client-side use only!
    var idToken: String = ""  // Safe to send to the server
    var fullName: String = ""
    var email: String = ""
    var imageURL: URL!
}
