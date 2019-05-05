//
//  DataProvider.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

protocol LocationSelectionDelegate: class {
    func didSelectLocation(info: StudentInformation)
}

class DataProvider: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: LocationSelectionDelegate?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentsLocation.shared.studentsInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationCell.identifier, for: indexPath) as! LocationCell
        cell.configWith(StudentsLocation.shared.studentsInformation[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectLocation(info: StudentsLocation.shared.studentsInformation[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
