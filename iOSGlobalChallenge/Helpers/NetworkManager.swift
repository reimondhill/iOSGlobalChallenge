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
    
    static let shared = NetworkManager()
    let network:Network
    
    let disposeBag = DisposeBag()
    
    //OBS -> Persistancy is done by UserDefaults. Despite the app being prepared for CoreData, there is not enought content right now. Maybe in the future.
    let lastPath:BehaviorRelay<String?> = BehaviorRelay(value: nil)
    private let lastPathIdentifier = "lastPathIdentifier"
    private let userDefaults = UserDefaults.standard
    

    //MARK:- Constructor
    required init(network:Network = AppNetwork()){
        
        self.network = network
        if let lastPath = userDefaults.value(forKey: lastPathIdentifier) as? String{
            self.lastPath.accept(lastPath)
        }
        
        super.init()
        setupBinders()
        
    }
    
}


//MARK:- Public methods
extension NetworkManager{
    
    ///Retrieves a new 'nextPath' and a new code
    func generatePathAndGetCode() throws -> Observable<CodeResponse>{

        return Observable<CodeResponse>.create({ [weak self] (observer) -> Disposable in
            guard let strongSelf = self else{ return Disposables.create() }
            
            do{
                let newPathResponseObservable = try strongSelf.generateNewPath()
                newPathResponseObservable.subscribe(onNext: { (_) in
                    
                    do{
                        let codeResponseObservable = try strongSelf.generateCode()
                        codeResponseObservable.subscribe(onNext: { (codeResponse) in
                            observer.onNext(codeResponse)
                            observer.onCompleted()
                        }, onError: { (error) in
                            observer.onError(error)
                        })
                        .disposed(by: strongSelf.disposeBag)
                    }
                    catch{
                        observer.onError(error)
                    }
                    
                    
                }, onError: { (error) in
                    observer.onError(error)
                })
                .disposed(by: strongSelf.disposeBag)
                
            }
            catch{
                observer.onError(error)
            }
            
            return Disposables.create()
        })

    }
    
    ///Retrieve the new code using the 'lastPath'. If nil or invalid, it will generate a newPath and get the code
    func generateCode() throws ->Observable<CodeResponse>{
        
        if let lastPath =  lastPath.value{
            
            let nextPath = "\(network.baseURLString)/\(lastPath)/"
            
            guard let baseURL = URL(string: nextPath) else {
                throw NetworkError.invalidURL
            }
            
            return Observable<CodeResponse>.create({ [weak self] (observer) -> Disposable in
                
                guard let strongSelf = self else{
                    observer.onCompleted()
                    return Disposables.create()
                }
                
                print(strongSelf.logClassName, "Getting code from, ", baseURL)
                
                let codeResponseObservable:Observable<CodeResponse> = strongSelf.network.fetchCodable(urlRequest: URLRequest(url: baseURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5))
                
                codeResponseObservable.subscribe(onNext: { (codeResponse) in
                    
                    observer.onNext(codeResponse)
                    observer.onCompleted()
                    
                }, onError: { (error) in
                    
                    do{
                        
                        try strongSelf.generatePathAndGetCode().subscribe(onNext: { (codeResponse) in
                            observer.onNext(codeResponse)
                            observer.onCompleted()
                        }, onError: { (error) in
                            strongSelf.lastPath.accept(nil)
                            observer.onError(error)
                        })
                        .disposed(by: strongSelf.disposeBag)
                        
                    }
                    catch{
                        observer.onError(error)
                    }
    
                })
                    .disposed(by: strongSelf.disposeBag)
                
                return Disposables.create()
                
            })
            
        }
        else{
            return try generatePathAndGetCode()
        }
        
    }
    
    ///Retrieves a new path
    func generateNewPath() throws ->Observable<PathResponse>{
        
        
        guard let baseURL = URL(string: network.baseURLString) else {
            throw NetworkError.invalidURL
        }
        
        return Observable<PathResponse>.create({ [weak self] (observer) -> Disposable in
            
            guard let strongSelf = self else{
                observer.onCompleted()
                return Disposables.create()
            }
            
            let pathObservable: Observable<PathResponse> = strongSelf.network.fetchCodable(urlRequest: URLRequest(url: baseURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 5))
            
            pathObservable.subscribe(onNext: { (pathResponse) in
                
                if let pathString = pathResponse.nextPath{
                    //OBS -> Assuming the response is correct by now
                    let pathStringComponents = pathString.components(separatedBy: "/")
                    strongSelf.lastPath.accept(pathStringComponents[pathStringComponents.count - 2])
                }
                else{
                    strongSelf.lastPath.accept(nil)
                }
                observer.onNext(pathResponse)
                observer.onCompleted()
                
            },onError: { (error) in
                strongSelf.lastPath.accept(nil)
                observer.onError(error)
            })
            .disposed(by: strongSelf.disposeBag)
            
            return Disposables.create()
            
        })
        
    }
    
}


//MARK:- Private methods
private extension NetworkManager{
    
    func setupBinders(){
        
        lastPath
            .asObservable()
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] (lastPath) in
                
                guard let strongSelf = self else{ return }
                strongSelf.userDefaults.set(lastPath, forKey: strongSelf.lastPathIdentifier)
                
            })
            .disposed(by: disposeBag)
        
    }
    
}
