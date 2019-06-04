//
//  StudentInformation.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import Foundation

struct StudentInformation : Codable {
    
    let createdAt: String?
    let firstName: String
    let lastName: String
    let latitude: Double?
    let longitude: Double?
    let mapString: String?
    let mediaURL: String?
    let objectID: String?
    let uniqueKey: String?
    let updatedAt: String?
    
    init(_ dictionary: [String: AnyObject]) {
        self.createdAt = dictionary["createdAt"] as? String
        self.uniqueKey = dictionary["uniqueKey"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.mapString = dictionary["mapString"] as? String ?? ""
        self.mediaURL = dictionary["mediaURL"] as? String ?? ""
        self.latitude = dictionary["latitude"] as? Double ?? 0.0
        self.longitude = dictionary["longitude"] as? Double ?? 0.0
        self.objectID = dictionary["objectID"] as? String
        self.updatedAt = dictionary["updatedAt"] as? String
    }
    var labelName: String {
        var name = ""
        if !firstName.isEmpty {
            name = firstName
        }
        if !lastName.isEmpty {
            if name.isEmpty {
                name = lastName
            } else {
                name += " \(lastName)"
            }
        }
        if name.isEmpty {
            name = "No name provided"
        }
        return name
    }
    
}
