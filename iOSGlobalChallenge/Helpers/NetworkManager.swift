//
//  NetworkManager.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit
import RxSwift

class NetworkManager: NSObject {
    
    //MARK:- Properties
    //MARK: Constants
    enum NetworkHelperError:Error{
        case noResponse
    }
    
    static let shared = NetworkManager()
    let network:Network
    let disposeBag = DisposeBag()
    
    
    //MARK:- Constructor
    required init(network:Network = AppNetwork()){
        
        self.network = network
        super.init()
        
    }
    
}


//MARK:- Public methods
extension NetworkManager{
    
    func getCodeResponse(){
        
        
        
    }
    
    func generateNewPath() throws ->Observable<PathResponse>{
        
        
        guard let baseURL = URL(string: network.baseURLString) else {
            throw NetworkError.invalidURL
        }
        return network.fetchCodable(urlRequest: URLRequest(url: baseURL))
        
    }
    
}


/*
 func generateNewPath()->Observable<PathResponse>{
 
 return Observable<PathResponse>.create({ [weak self] (observer) -> Disposable in
 
 self!.network.fetchCodable(urlRequest: URLRequest(url: URL(string: "http:")!))
 
 return Disposables.create()
 
 })
 
 }
 */
