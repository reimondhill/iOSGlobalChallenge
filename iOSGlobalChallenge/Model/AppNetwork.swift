//
//  AppNetwork.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import RxSwift


class AppNetwork:NSObject, Network{
    
    var baseURLString: String{
        
        if let ipEndpoint = ProcessInfo.processInfo.environment["IP"] {
            print(logClassName, "Got IP = \(ipEndpoint)")
            return "http://\(ipEndpoint):8000"
        }
        return "http://localhost:8000"
    }
    
    
    func fetchCodable<T>(urlRequest: URLRequest) -> Observable<T> where T : Decodable, T : Encodable {
        
        return Observable<T>.create({ [weak self] (observer) -> Disposable in
            
            self?.performRequest(urlRequest, completion: { result in
                
                switch result{
                    
                case .success(let data):
                    do{
                        let model = try JSONDecoder().decode(T.self, from: data)
                        observer.onNext(model)
                    }
                    catch{
                        observer.onError(error)
                    }
                case .failure(let error):
                    observer.onError(error)
                    
                }
                
                observer.onCompleted()
                
            })
            
            return Disposables.create()
            
        })
        
    }
    
}


//MARK:- Private methods
//To be reused in the future
private extension AppNetwork{
    
    func performRequest(_ urlRequest: URLRequest, completion: @escaping ((Result<Data, Error>)->Void) ){
        
        guard urlRequest.url != nil else{
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let urlSession = URLSession(configuration: sessionConfig)
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                let response = response as? HTTPURLResponse,
                (200 ..< 300) ~= response.statusCode else{
                    
                    completion(.failure(NetworkError.dataCorrupted))
                    return
                    
            }
            
            completion(.success(data))
            
            }.resume()
        
    }
    
}
