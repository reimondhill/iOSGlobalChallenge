//
//  NetworkURL.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 17/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class NetworkURL:NSObject {
    
    //MARK:- Properties
    private let disposeBag = DisposeBag()
    
    //OBS -> Persistancy is done by UserDefaults. Despite the app being prepared for CoreData, there is not enought content right now. Maybe in the future.
    private let userDefaults = UserDefaults.standard
    private let nextURLIdentifier = "nextURLIdentifier"
    
    var baseURL:BehaviorRelay<URL?>
    var nextURL:BehaviorRelay<URL?> = BehaviorRelay(value: nil)
    
    
    
    //MARK:- Constructor
    init(shouldStore:Bool = true){
        
        if let ipEndpoint = ProcessInfo.processInfo.environment["IP"] {
            print("Got IP = ", ipEndpoint)
            self.baseURL = BehaviorRelay(value: URL(string: "http://\(ipEndpoint):8000"))
        }
        else{
            self.baseURL = BehaviorRelay(value: URL(string: "http://localhost:8000"))
        }
        
        super.init()
        
        if shouldStore{
            if let nextURLString = userDefaults.value(forKey: nextURLIdentifier) as? String,
                let nextURL = URL(string: nextURLString){
                
                self.nextURL.accept(nextURL)
                
            }
            
            setupBinders()
        }
        
    }
    
    func setupBinders(){
        
        nextURL
            .asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { (nextURL) in
                
                self.userDefaults.set(nextURL?.absoluteString, forKey: self.nextURLIdentifier)
                
            })
            .disposed(by: disposeBag)
        
    }
    
}


