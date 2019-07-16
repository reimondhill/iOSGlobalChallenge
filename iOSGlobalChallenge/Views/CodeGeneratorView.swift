//
//  CodeGeneratorView.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class CodeGeneratorView: UIView {
    
    //MARK:- Properties
    //MARK: Constants
    let networkManager:NetworkManager
    
    //MARK:- Variables
    var counter = 0
    
    //UI
    lazy private (set) var generateButton:BaseButton = { return BaseButton(withConfiguration: .normal) }()
    
    
    //MARK:- Constructor
    init(networkManager:NetworkManager) {
        self.networkManager = networkManager
        super.init(frame: .zero)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Lifecycle methods
extension CodeGeneratorView{
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        if superview != nil{
            setupView()
        }
        
    }
    
}


//MARK:- Private methods
private extension CodeGeneratorView{
    
    func setupView(){
        
        addSubview(generateButton)
        generateButton.anchor(top: nil,
                              leading: leadingAnchor,
                              bottom: bottomAnchor,
                              trailing: trailingAnchor,
                              padding: .init(padding: Margins.medium),
                              size: .init(width: 0, height: Heights.button))
        
    }
    
}
