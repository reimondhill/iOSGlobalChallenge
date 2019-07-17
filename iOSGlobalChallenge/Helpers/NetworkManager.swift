//
//  NetworkManager.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class NetworkManager: NSObject {
    
    //MARK:- Properties
    //MARK: Constants
    enum Errors:Error{
        case noResponse
    }
    
    let disposeBag = DisposeBag()
    
    let network:Network
    let networkURL:NetworkURL
    
    
    
    //MARK:- Constructor
    required init(network:Network = AppNetwork(), networkURL:NetworkURL = NetworkURL()){
        
        self.network = network
        self.networkURL = networkURL
        super.init()
        
    }
    
}


//MARK:- Public methods
extension NetworkManager{
    
    ///Retrieves a new 'nextPath' and a new code
    func generatePathAndGetCode() -> Observable<CodeResponse>{

        return Observable<CodeResponse>.create({ [weak self] (observer) -> Disposable in
            
            guard let strongSelf = self else{
                observer.onCompleted()
                return Disposables.create()
            }
            
            print("TEST -> ", strongSelf.networkURL.baseURL.value)
            print("TEST -> ", strongSelf.networkURL.nextURL.value)
            
            strongSelf.generateNewPath().subscribe(onNext: { (_) in
                
                strongSelf.generateCode().subscribe(onNext: { (codeResponse) in
                    observer.onNext(codeResponse)
                    observer.onCompleted()
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: strongSelf.disposeBag)
                
            }, onError: { (error) in
                observer.onError(error)
            })
                .disposed(by: strongSelf.disposeBag)
            
            return Disposables.create()
        })

    }
    
    ///Retrieve the new code using the 'lastPath'. If nil or invalid, it will generate a newPath and get the code
    func generateCode() -> Observable<CodeResponse>{
        
        if let nextURL =  networkURL.nextURL.value{
            print(logClassName, "Getting code from, ", nextURL)
            
            return Observable<CodeResponse>.create({ [weak self] (observer) -> Disposable in
                
                guard let strongSelf = self else{
                    observer.onCompleted()
                    return Disposables.create()
                }
                
                let codeResponseObservable:Observable<CodeResponse> = strongSelf.network.fetchCodable(urlRequest: URLRequest(url: nextURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10))
                
                codeResponseObservable.subscribe(onNext: { (codeResponse) in
                    
                    observer.onNext(codeResponse)
                    observer.onCompleted()
                    
                }, onError: { (error) in
                    
                    strongSelf.generatePathAndGetCode().subscribe(onNext: { (codeResponse) in
                        observer.onNext(codeResponse)
                        observer.onCompleted()
                    }, onError: { (error) in
                        strongSelf.networkURL.nextURL.accept(nil)
                        observer.onError(error)
                    })
                    .disposed(by: strongSelf.disposeBag)
                    
                })
                .disposed(by: strongSelf.disposeBag)
                
                return Disposables.create()
                
            })
            
        }
        else{
            return generatePathAndGetCode()
        }
        
    }
    
    ///Retrieves a new path
    func generateNewPath() ->Observable<PathResponse>{
        
        return Observable<PathResponse>.create({ [weak self] (observer) -> Disposable in
            
            guard let strongSelf = self else{
                observer.onCompleted()
                return Disposables.create()
            }
            
            guard let baseURL = strongSelf.networkURL.baseURL.value else{
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let pathObservable: Observable<PathResponse> = strongSelf.network.fetchCodable(urlRequest: URLRequest(url: baseURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5))
            
            pathObservable.subscribe(onNext: { (pathResponse) in
                
                if let pathString = pathResponse.nextPath{
                    strongSelf.networkURL.nextURL.accept(URL(string: pathString))
                }
                else{
                    strongSelf.networkURL.nextURL.accept(nil)
                }
                observer.onNext(pathResponse)
                observer.onCompleted()
                
            },onError: { (error) in
                strongSelf.networkURL.nextURL.accept(nil)
                observer.onError(error)
            })
            .disposed(by: strongSelf.disposeBag)
            
            return Disposables.create()
            
        })
        
    }
    
}
