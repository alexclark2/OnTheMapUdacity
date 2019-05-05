//
//  ViewController+Extensions.swift
//  On The Map
//
//  Created by MACBOOK on 3/16/19.
//  Copyright © 2019 Alexander. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func showInfo(withTitle: String = "Info", withMessage: String, action: (() -> Void)? = nil) {
        performUIUpdatesOnMain {
            let ac = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alertAction) in
                action?()
            }))
            self.present(ac, animated: true)
        }
    }
    
    func showConfirmationAlert(withMessage: String, actionTitle: String, action: @escaping () -> Void) {
        performUIUpdatesOnMain {
            let ac = UIAlertController(title: nil, message: withMessage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            ac.addAction(UIAlertAction(title: actionTitle, style: .destructive, handler: { (alertAction) in
                action()
            }))
            self.present(ac, animated: true)
        }
    }
    
    func performUIUpdatesOnMain(_ updates: @escaping () -> Void) {
        DispatchQueue.main.async {
            updates()
        }
    }
    
    func enableUI(views: UIControl..., enable: Bool) {
        performUIUpdatesOnMain {
            for view in views {
                view.isEnabled = enable
            }
        }
    }
    
    
    func openWithSafari(_ url: String) {
        guard let url = URL(string: url), UIApplication.shared.canOpenURL(url) else {
            showInfo(withMessage: "Invalid link.")
            return
        }
        UIApplication.shared.open(url, options: [:])
    }
}
