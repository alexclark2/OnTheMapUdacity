//
//  StudentsLocation.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//


import Foundation

struct StudentsLocation {
    
    static var shared = StudentsLocation()
    
    private init() {}
    
    var studentsInformation = [StudentInformation]()
    
}
