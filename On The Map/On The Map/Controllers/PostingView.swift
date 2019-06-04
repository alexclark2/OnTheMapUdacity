//
//  PostingView.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit
import CoreLocation

class PostingView: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldLink: UITextField!
    @IBOutlet weak var buttonFindLocation: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var objectID: String?
    
    var textFieldLocationIsEmpty = true
    var textFieldLinkIsEmpty = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldLocation.delegate = self
        textFieldLink.delegate = self
        buttonEnabled(false, button: buttonFindLocation)
    }
    
    
    @IBAction func cancelPostingView(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func findLocation(sender: UIButton) {
        self.setLoading(true)
        let newLocation = textFieldLocation.text
        
        guard let url = URL(string: self.textFieldLink.text!), UIApplication.shared.canOpenURL(url) else {
            self.showAlert(message: "Please include 'http://' in your link.", title: "Invalid URL")
            setLoading(false)
            return
        }
        
        geocodePosition(newLocation: newLocation ?? "")
    }
    
    
    private func geocodePosition(newLocation: String) {
        CLGeocoder().geocodeAddressString(newLocation) { (newMarker, error) in
            if let error = error {
                self.showAlert(message: error.localizedDescription, title: "Location Not Found")
                self.setLoading(false)
                print("Location not found.")
            } else {
                var location: CLLocation?
                
                if let marker = newMarker, marker.count > 0 {
                    location = marker.first?.location
                }
                
                if let location = location {
                    self.loadNewLocation(location.coordinate)
                } else {
                    self.showAlert(message: "Please try again later.", title: "Error")
                    self.setLoading(false)
                    print("There was an error.")
                }
            }
        }
    }
    
    
    private func loadNewLocation(_ coordinate: CLLocationCoordinate2D) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "FinishAddLocationViewController") as! FinishAddLocationViewController
        controller.studentInformation = buildStudentInfo(coordinate)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    private func buildStudentInfo(_ coordinate: CLLocationCoordinate2D) -> StudentInformation {
        
        var studentInfo = [
            "uniqueKey": Client.Auth.key,
            "firstName": Client.Auth.firstName,
            "lastName": Client.Auth.lastName,
            "mapString": textFieldLocation.text!,
            "mediaURL": textFieldLink.text!,
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            ] as [String: AnyObject]
        
        if let objectID = objectID {
            studentInfo["objectID"] = objectID as AnyObject
            print(objectID)
        }
        
        return StudentInformation(studentInfo)
        
    }
    
    
    func setLoading(_ loading: Bool) {
        if loading {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.buttonEnabled(false, button: self.buttonFindLocation)
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.buttonEnabled(true, button: self.buttonFindLocation)
            }
        }
        DispatchQueue.main.async {
            self.textFieldLocation.isEnabled = !loading
            self.textFieldLink.isEnabled = !loading
            self.buttonFindLocation.isEnabled = !loading
        }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == textFieldLocation {
            let currenText = textFieldLocation.text ?? ""
            guard let stringRange = Range(range, in: currenText) else { return false }
            let updatedText = currenText.replacingCharacters(in: stringRange, with: string)
            
            if updatedText.isEmpty && updatedText == "" {
                textFieldLocationIsEmpty = true
            } else {
                textFieldLocationIsEmpty = false
            }
        }
        
        if textField == textFieldLink {
            let currenText = textFieldLink.text ?? ""
            guard let stringRange = Range(range, in: currenText) else { return false }
            let updatedText = currenText.replacingCharacters(in: stringRange, with: string)
            
            if updatedText.isEmpty && updatedText == "" {
                textFieldLinkIsEmpty = true
            } else {
                textFieldLinkIsEmpty = false
            }
        }
        
        if textFieldLocationIsEmpty == false && textFieldLinkIsEmpty == false {
            buttonEnabled(true, button: buttonFindLocation)
        } else {
            buttonEnabled(false, button: buttonFindLocation)
        }
        
        return true
        
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        buttonEnabled(false, button: buttonFindLocation)
        if textField == textFieldLocation {
            textFieldLocationIsEmpty = true
        }
        if textField == textFieldLink {
            textFieldLinkIsEmpty = true
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            findLocation(sender: buttonFindLocation)
            
        }
        return true
    }
    
}
