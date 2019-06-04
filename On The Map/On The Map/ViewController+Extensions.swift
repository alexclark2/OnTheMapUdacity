//
//  ViewController+Extensions.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    @IBAction func postingView(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "postingView", sender: sender)
    }
    
    // MARK: Enabled and disabled states for buttons
    
    func buttonEnabled(_ enabled: Bool, button: UIButton) {
        if enabled {
            button.isEnabled = true
            button.alpha = 1.0
        } else {
            button.isEnabled = false
            button.alpha = 0.5
        }
    }
    
    // MARK: Show alerts
    
    func showAlert(message: String, title: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertVC, animated: true)
    }
    
    // MARK: Open links in Safari
    
    func openLink(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            showAlert(message: "Cannot open link.", title: "Invalid Link")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
    
}
