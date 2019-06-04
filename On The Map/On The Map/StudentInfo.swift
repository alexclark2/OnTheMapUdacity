//
//  StudentInfo.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

    struct StudentInfo: Codable {
        
        let objectID: String
        let uniqueKey: String
        let firstName: String
        let lastName: String
        let mapString: String
        let mediaURL: String
        let createdAt: String
        let updatedAt: String
        var latitude: Double
        var longitude: Double
        
        
        enum CodingKeys: String, CodingKey {
            case objectID = "objectID"
            case uniqueKey = "uniqueKey"
            case firstName = "firstName"
            case lastName = "lastName"
            case mapString = "mapString"
            case mediaURL = "mediaURl"
            case createdAt = "createdAt"
            case updatedAt = "updatedAt"
            case longitude = "longitude"
            case latitude = "latitude"
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
                    name += " \(lastName))"
                }
            }
            if name.isEmpty {
                name = "No name provided"
            }
            return name
        }
}
