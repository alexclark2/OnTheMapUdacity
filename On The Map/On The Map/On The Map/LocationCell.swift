//
//  LocationCell.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {
    
    static let identifier = "LocationCell"
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUrl: UILabel!
    
    func configWith(_ info: StudentInformation) {
        labelName.text = info.labelName
        labelUrl.text = info.mediaURL
    }
    
}
