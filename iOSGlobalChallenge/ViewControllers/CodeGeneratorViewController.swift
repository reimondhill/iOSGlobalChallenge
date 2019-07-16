//
//  CodeGeneratorViewController.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit

class CodeGeneratorViewController: BaseViewController {
    
    //MARK:- Properties
    //MARK: Constants
    let networkManager:NetworkManager
    
    
    //MARK: Vatriables
    //UI
    lazy private (set) var codeGeneratorView:CodeGeneratorView = { return CodeGeneratorView(networkManager: networkManager) }()
    
    
    //MARK:- Constructor
    init(networkManager:NetworkManager) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK:- Lifecycle methods
extension CodeGeneratorViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
}


//MARK:- Private methods
private extension CodeGeneratorViewController{
    
    func setupView(){
        
        view.addSubview(codeGeneratorView)
        codeGeneratorView.constraintToSuperViewEdges(padding: .init(padding: Margins.medium), safeView: true)
        
    }
    
}
