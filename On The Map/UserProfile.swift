//
//  UserProfile.swift
//  On The Map
//
//  Created by MACBOOK on 3/29/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import Foundation

struct UserProfile: Codable {
    let firstName: String
    let lastName: String
    let nickname: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case lastName = "lastName"
        case nickname
    }
    
}
