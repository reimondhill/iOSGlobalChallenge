//
//  BaseViewController.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    //MARK:- Properties
    //MARK: Vars
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
}


//MARK:- Lifecycle methods
extension BaseViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainViewBackground
        view.accessibilityIdentifier = identifier
        
    }
    
}
