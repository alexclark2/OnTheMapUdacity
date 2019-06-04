//
//  FinishAddLocationViewController.swift
//  On The Map
//
//  Created by MACBOOK on 6/3/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit
import MapKit

class FinishAddLocationViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var finishAddLocationButton: UIButton!
    
    var studentInformation: StudentInformation?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let studentLocation = studentInformation {
            let studentLocation = Location(
                objectID: studentLocation.objectID ?? "",
                uniqueKey: studentLocation.uniqueKey,
                firstName: studentLocation.firstName,
                lastName: studentLocation.lastName,
                mapString: studentLocation.mapString,
                mediaURL: studentLocation.mediaURL,
                latitude: studentLocation.latitude,
                longitude: studentLocation.longitude,
                createdAt: studentLocation.createdAt ?? "",
                updatedAt: studentLocation.updatedAt ?? ""
            )
            showLocations(location: studentLocation)
        }
    }
    
    @IBAction func finishAddLocation(_ sender: UIButton) {
        self.setLoading(true)
        if let studentLocation = studentInformation {
            if Client.Auth.objectID == "" {
                Client.addStudentLocation(information: studentLocation) { (success, error) in
                    if success {
                        DispatchQueue.main.async {
                            self.setLoading(true)
                            self.dismiss(animated: true, completion: nil)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(message: error?.localizedDescription ?? "", title: "level 1")
                            self.setLoading(false)
                        }
                    }
                }
            } else {
                let alertVC = UIAlertController(title: "", message: "Location Already Posted by student. Would you like to overwrite this location?", preferredStyle: .alert)
                alertVC.addAction(UIAlertAction(title: "Overwrite", style: .default, handler: { (action: UIAlertAction) in
                    Client.updateStudentLocation(information: studentLocation) { (success, error) in
                        if success {
                            DispatchQueue.main.async {
                                self.setLoading(true)
                                self.dismiss(animated: true, completion: nil)
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.showAlert(message: error?.localizedDescription ?? "", title: "level 2")
                                self.setLoading(false)
                            }
                        }
                    }
                }))
                alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction) in
                    DispatchQueue.main.async {
                        self.setLoading(false)
                        alertVC.dismiss(animated: true, completion: nil)
                    }
                }))
                self.present(alertVC, animated: true)
            }
        }
    }
    
    
    private func showLocations(location: Location) {
        mapView.removeAnnotations(mapView.annotations)
        if let coordinate = extractCoordinate(location: location) {
            let annotation = MKPointAnnotation()
            annotation.title = location.locationLabel
            annotation.subtitle = location.mediaURL ?? ""
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
            mapView.showAnnotations(mapView.annotations, animated: true)
        }
    }
    
    private func extractCoordinate(location: Location) -> CLLocationCoordinate2D? {
        if let lat = location.latitude, let lon = location.longitude {
            return CLLocationCoordinate2DMake(lat, lon)
        }
        return nil
    }
    
    
    func setLoading(_ loading: Bool) {
        if loading {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
                self.buttonEnabled(false, button: self.finishAddLocationButton)
            }
        } else {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.buttonEnabled(true, button: self.finishAddLocationButton)
            }
        }
        DispatchQueue.main.async {
            self.finishAddLocationButton.isEnabled = !loading
        }
    }
    
}
