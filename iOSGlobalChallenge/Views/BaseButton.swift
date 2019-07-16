//
//  BaseButton.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class BaseButton: UIButton {

    //MARK:- Properties
    //MARK: Constants
    enum ButtonConfiguration:Int, CaseIterable{
        case normal = 0
        //More to come
    }
    
    
    
    //MARK: Variables
    @IBInspectable var cornerRadius:CGFloat = BorderRadius.medium{
        didSet{
            layer.cornerRadius = cornerRadius
            setNeedsDisplay()
        }
    }
    @IBInspectable var borderWidth:CGFloat = Separators.xSmall{
        didSet{
            layer.borderWidth = borderWidth
            setNeedsDisplay()
        }
    }

    var buttonConfiguration:ButtonConfiguration = .normal{
        didSet{
            setupView()
        }
    }
    @IBInspectable var buttonConfigurationOption:Int{
        get{
            return buttonConfiguration.rawValue
        }
        set{
            guard let buttonConfigurationTemp = ButtonConfiguration(rawValue: newValue) else{ return }
            buttonConfiguration = buttonConfigurationTemp
        }
    }
    

    override var isEnabled: Bool{
        didSet{
        
            switch buttonConfiguration {
            case .normal:
                layer.borderColor = isEnabled ? UIColor.mainButtonBorder.cgColor : UIColor.mainButtonDisabledBorder.cgColor
                setNeedsDisplay()
                
            }
        }
    }
    
    
    
    //MARK:- Constructor
    init(withConfiguration buttonConfiguration:ButtonConfiguration) {
        
        self.buttonConfiguration = buttonConfiguration
        super.init(frame: CGRect())
        
        setupView()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupView()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
        
    }
    
}
    

//MARK:- Private methods
private extension BaseButton{
    
    private func setupView(){
        
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        
        switch buttonConfiguration {
            
        case .normal:
            
            backgroundColor = UIColor.mainButtonBackground
            setBackgroundColor(UIColor.mainButtonBackground, for: .normal)
            
            setBackgroundColor(UIColor.mainButtonDisabledBackground, for: .disabled)
            
            setTitleColor(UIColor.mainButtonText, for: .normal)
            setTitleColor(UIColor.mainButtonDisabledText, for: .disabled)
            
            if let titleLabel = titleLabel{
                titleLabel.font = UIFont.systemFont(ofSize: TextSize.normal, weight: .semibold)
            }
            
            clipsToBounds = true
            
        }
        
        
    }
    
}
