//
//  MockNetwork.swift
//  iOSGlobalChallengeTests
//
//  Created by Ramon Haro Marques on 17/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import XCTest
@testable import iOSGlobalChallenge

import Foundation
import RxSwift


class MockNetwork: NSObject, Network {
    
    var baseURLString: String{
        guard let url = Bundle.main.url(forResource: "nextPathResponse", withExtension: "json") else{ return "" }
        return url.absoluteString
    }
    
    func fetchCodable<T>(urlRequest: URLRequest) -> Observable<T> where T : Decodable, T : Encodable {
        
         return Observable<T>.create({ (observer) -> Disposable in
        
            guard let url = urlRequest.url else{
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            do{
                let model = try JSONDecoder().decode(T.self, from: try Data(contentsOf: url))
                observer.onNext(model)
            }
            catch{
                observer.onError(error)
            }
            
            observer.onCompleted()
            
            return Disposables.create()
            
         })
        
    }
    
}
