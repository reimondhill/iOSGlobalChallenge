//
//  Network.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import RxSwift

enum NetworkError:Error {
    case dataCorrupted
    case invalidURL
}

protocol NetworkURL {
    
    ///StringURL for baseURL
    var baseURLString:String{get}

}

protocol Network:NetworkURL {
    
    /// Perform GET/POST request returning the result decoded object
    ///
    /// - Parameters:
    ///   - urlRequest: Url request with the request config
    ///   - completion: Result type handler called the request has finished.
    //func fetchCodable<T:Codable>(urlRequest:URLRequest, completion:@escaping (Result<T,Error>)->Void)
    
    func fetchCodable<T:Codable>(urlRequest:URLRequest) -> Observable<T>
    
}
