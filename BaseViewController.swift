//
//  BaseViewController.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class BaseViewController: UITabBarController {
    
    @IBOutlet weak var buttonPostLocation: UIBarButtonItem!
    @IBOutlet weak var buttonPostReload: UIBarButtonItem!
    @IBOutlet weak var buttonLogout: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(loadStudentsInformation), name: .reload, object: nil)
        loadStudentsInformation()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func logout(_ sender: Any) {
        Client.shared().logout { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.showInfo(withTitle: "Error", withMessage: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func reload(_ sender: Any) {
        loadStudentsInformation()
    }
    
    @IBAction func updateLocation(_ sender: Any) {
        enableControllers(false)
        Client.shared().studentInformation { (studentInformation, error) in
            if let error = error {
                self.showInfo(withTitle: "Error fetching student location", withMessage: error.localizedDescription)
            } else if let studentInformation = studentInformation {
                let msg = "User \"\(studentInformation.labelName)\" has already posted a Student Location. Whould you like to Overwrite it?"
                self.showConfirmationAlert(withMessage: msg, actionTitle: "Overwrite", action: {
                    self.showPostingView(studentLocationID: studentInformation.locationID)
                })
            } else {
                self.performUIUpdatesOnMain {
                    self.showPostingView()
                }
            }
            self.enableControllers(true)
        }
    }
    
    
    @objc private func loadStudentsInformation() {
        NotificationCenter.default.post(name: .reloadStarted, object: nil)
        Client.shared().studentsInformation { (studentsInformation, error) in
            if let error = error {
                self.showInfo(withTitle: "Error", withMessage: error.localizedDescription)
                NotificationCenter.default.post(name: .reloadCompleted, object: nil)
                return
            }
            if let studentsInformation = studentsInformation {
                StudentsLocation.shared.studentsInformation = studentsInformation
            }
            NotificationCenter.default.post(name: .reloadCompleted, object: nil)
        }
    }
    
    private func enableControllers(_ enable: Bool) {
        performUIUpdatesOnMain {
            self.buttonPostLocation.isEnabled = enable
            self.buttonPostReload.isEnabled = enable
            self.buttonLogout.isEnabled = enable
        }
    }
    
    private func showPostingView(studentLocationID: String? = nil) {
        let postingView = storyboard?.instantiateViewController(withIdentifier: "PostingView") as! PostingView
        postingView.locationID = studentLocationID
        navigationController?.pushViewController(postingView, animated: true)
    }
    
}

