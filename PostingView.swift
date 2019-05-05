//
//  PostingView.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit
import CoreLocation

class PostingView: UIViewController {
    
    
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldLink: UITextField!
    @IBOutlet weak var buttonFindLocation: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var locationID: String?
    lazy var geocoder = CLGeocoder()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonFindLocation.roundCorners()
        setUpNavBar()
    }
    
  
    
    @IBAction func findLocation(_ sender: Any) {
        
        let location = textFieldLocation.text!
        let link = textFieldLink.text!
        
        if location.isEmpty || link.isEmpty {
            showInfo(withMessage: "All fields are required.")
            return
        }
        guard let url = URL(string: link), UIApplication.shared.canOpenURL(url) else {
            showInfo(withMessage: "Please provide a valid link.")
            return
        }
        geocode(location: location)
    }
    

    
    private func geocode(location: String) {
        enableControllers(false)
        activityIndicator.startAnimating()
        geocoder.geocodeAddressString(location) { (placemarkers, error) in
            
            self.enableControllers(true)
            self.performUIUpdatesOnMain {
                self.activityIndicator.stopAnimating()
            }
            
            if let error = error {
                self.showInfo(withTitle: "Error", withMessage: "Unable to Forward Geocode Address (\(error))")
            } else {
                var location: CLLocation?
                
                if let placemarks = placemarkers, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    self.syncStudentLocation(location.coordinate)
                } else {
                    self.showInfo(withMessage: "No Matching Location Found")
                }
            }
        }
    }
    
    private func syncStudentLocation(_ coordinate: CLLocationCoordinate2D) {
        self.enableControllers(true)
        
        let viewController = storyboard?.instantiateViewController(withIdentifier: "MapPinLocationView") as! MapPinLocationView
        viewController.studentInformation = buildStudentInfo(coordinate)
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    private func buildStudentInfo(_ coordinate: CLLocationCoordinate2D) -> StudentInformation {
        let nameComponents = Client.shared().userName.components(separatedBy: " ")
        let firstName = nameComponents.first ?? ""
        let lastName = nameComponents.last ?? ""
        
        var studentInfo = [
            "uniqueKey": Client.shared().userKey,
            "firstName": firstName,
            "lastName": lastName,
            "mapString": textFieldLocation.text!,
            "mediaURL": textFieldLink.text!,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            ] as [String: AnyObject]
        
        if let locationID = locationID {
            studentInfo["objectId"] = locationID as AnyObject
        }
        return StudentInformation(studentInfo)
    }
    
    private func enableControllers(_ enable: Bool) {
        self.enableUI(views: textFieldLocation, textFieldLink, buttonFindLocation, enable: enable)
    }
    
    private func setUpNavBar(){
        self.navigationItem.title = "Add Location"
        
        let backButton = UIBarButtonItem()
        backButton.title = "CANCEL"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
}
