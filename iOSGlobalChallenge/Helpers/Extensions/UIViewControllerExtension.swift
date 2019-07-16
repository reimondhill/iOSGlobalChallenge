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
    
    
    ///Adds a right item in the navigation bar and returns the UIButton. Further configuration outside this function.
    @discardableResult
    func addRightNavigationItem(withTitle title:String?)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.constraintToSuperViewEdges()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.navigationBarText, for: .normal)
        button.titleLabel!.textAlignment = .center
        
        if navigationItem.rightBarButtonItems == nil{
            navigationItem.rightBarButtonItems = []
        }
        navigationItem.rightBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    @discardableResult
    func addRightNavigationItem(withImage image:UIImage)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.navigationBarTint
        
        if navigationItem.rightBarButtonItems == nil{
            navigationItem.rightBarButtonItems = []
        }
        navigationItem.rightBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    ///Adds a left item in the navigation bar and returns the UIButton. Further configuration outside this function.
    @discardableResult
    func addLeftNavigationItem(withTitle title:String?)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.constraintToSuperViewEdges()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.navigationBarText, for: .normal)
        button.titleLabel!.textAlignment = .center
        
        if navigationItem.leftBarButtonItems == nil{
            navigationItem.leftBarButtonItems = []
        }
        navigationItem.leftBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
    @discardableResult
    func addLeftNavigationItem(withImage image:UIImage)->UIButton{
        
        let holderView = UIButton()
        
        let button: UIButton = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        holderView.addSubview(button)
        
        button.trailingAnchor.constraint(equalTo: holderView.trailingAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: holderView.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.navigationBarTint
        
        if navigationItem.leftBarButtonItems == nil{
            navigationItem.leftBarButtonItems = []
        }
        navigationItem.leftBarButtonItems!.append(UIBarButtonItem(customView: holderView))
        
        return button
        
    }
    
}
