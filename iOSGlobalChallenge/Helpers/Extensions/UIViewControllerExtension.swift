//
//  UIViewControllerExtension.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit


extension UIViewController{
    
    //MARK:- Properties
    /// Returns the current trait status 
    var currentTraitStatus:DeviceTraitStatus{ return DeviceTraitStatus.current }

    
    //MARK:- Public methods
    /// Creates and presents new ConfirmationPopupViewController
    /// - Parameters:
    ///   - title: Title to be displayed
    ///   - message: Message to be displayed
    ///   - sender: The UIViewController that displays will present the ConfirmationPopupViewController
    ///   - completion: Callback when the ConfirmationPopupViewController has been dismissed
    func showAlert(withTitle title:String, message:String, sender:UIViewController, completion:(()->Void)?){
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("messages.ok", comment: ""), style: .default, handler: { (action) in
            completion?()
        }))
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    
}
