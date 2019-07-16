//
//  BaseLabel.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {

    //MARK:- Properties
    //MARK: Constants
    enum LabelConfiguration:Int, CaseIterable{
        //Custom NavBars
        case navBar = 0
        case normal = 1
        case normalLight = 2
        //More future cases
    }
    
    
    //MARK: Vars
    var labelConfiguration:LabelConfiguration = .normal{
        didSet{
            setupView()
        }
    }
    @IBInspectable var labelConfigurationOption:Int{
        get{
            return labelConfiguration.rawValue
        }
        set{
            guard let labelConfiguration = LabelConfiguration(rawValue: newValue) else{ return }
            self.labelConfiguration = labelConfiguration
        }
    }
    
    
    
    //MARK:- Constructor
    init(withConfiguration labelConfiguration:LabelConfiguration) {
        self.labelConfiguration = labelConfiguration
        super.init(frame: .zero)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        
    }
    
}


//MARK:- Private methods
private extension BaseLabel{
    
    func setupView(){
        
        numberOfLines = 0
        textAlignment = .left
        
        switch labelConfiguration {
        case .navBar:
            textColor = UIColor.navigationBarText
            font = UIFont.systemFont(ofSize: TextSize.navigationTitle, weight: .semibold)
        case .normal:
            textColor = UIColor.mainText
            font = UIFont.systemFont(ofSize: TextSize.normal, weight: .regular)
            textAlignment = .justified
        case .normalLight:
            textColor = UIColor.secondaryText
            font = UIFont.systemFont(ofSize: TextSize.normal, weight: .light)
        }
        
    }
    
}
