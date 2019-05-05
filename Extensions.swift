//
//  Extensions.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
}

extension Notification.Name {
    static let reload = Notification.Name("reload")
    static let reloadStarted = Notification.Name("reloadStarted")
    static let reloadCompleted = Notification.Name("reloadCompleted")
}
