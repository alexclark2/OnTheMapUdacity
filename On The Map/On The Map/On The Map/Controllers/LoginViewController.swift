//
//  LoginViewController.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var userEmail: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    @IBOutlet weak var buttonLogin: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var buttonSignUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail.delegate = self
        userPassword.delegate = self
        
        buttonLogin.roundCorners()
    }
    
    
    @IBAction func loginPressed(_ sender: AnyObject) {
        
        activityIndicator.startAnimating()
        enableControllers(false)
        
        guard  let email = userEmail.text, !email.isEmpty else {
            activityIndicator.stopAnimating()
            enableControllers(true)
            showInfo(withTitle: "Field required", withMessage: "Please fill in your email.")
            return
        }
        guard  let password = userPassword.text, !password.isEmpty else {
            activityIndicator.stopAnimating()
            enableControllers(true)
            showInfo(withTitle: "Field required", withMessage: "Please fill in your password.")
            return
        }
        authenticateUser(email: email, password: password)
    }
    
    @IBAction func signUpPressed(_ sender: AnyObject) {
        openWithSafari("https://auth.udacity.com/sign-up")
    }
    
    
    private func authenticateUser(email: String, password: String) {
        Client.shared().authenticateWith(userEmail: email, andPassword: password) { (success, errorMessage) in
            if success {
                self.performUIUpdatesOnMain {
                    self.userEmail.text = ""
                    self.userPassword.text = ""
                    self.performSegue(withIdentifier: "showMap", sender: nil)
                }
                
            } else {
                self.performUIUpdatesOnMain {
                    self.showInfo(withTitle: "Login failed", withMessage: errorMessage ?? "Error while performing login.")
                }
            }
            self.performUIUpdatesOnMain {
                self.activityIndicator.stopAnimating()
            }
            self.enableControllers(true)
        }
    }
    
    private func enableControllers(_ enable: Bool) {
        self.enableUI(views: userEmail, userPassword, buttonLogin, buttonSignUp, enable: enable)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
