//
//  ModelAndNeworkTests.swift
//  iOSGlobalChallengeTests
//
//  Created by Ramon Haro Marques on 17/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import XCTest
@testable import iOSGlobalChallenge
import Foundation
import RxSwift


class ModelAndNeworkTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testGenerateNewPath(){
        
        let networkManager = NetworkManager(network: MockNetwork(), networkURL: MockNetworkURL())
        
        networkManager.generateNewPath().subscribe(onNext: { (pathResponse) in
            
            XCTAssertEqual(pathResponse.nextPath, "http://localhost:8000/cc5baa07-a7f1-11e9-a227-b8e85641bcc4/")
            
        }, onError: { (error) in
            XCTFail(error.localizedDescription)
        })
        .disposed(by: disposeBag)
        
    }
    
    func testGetCodeResponse(){

        let networkManager = NetworkManager(network: MockNetwork(), networkURL: MockNetworkURL())
        networkManager.generateCode().subscribe(onNext: { (codeResponse) in
            XCTAssertEqual(codeResponse.responseCode, "0c9813ec-3ba8-4944-b025-5402860feebc")
        }, onError: { (error) in
             XCTFail(error.localizedDescription)
        })
        .disposed(by: disposeBag)
        
    }
    
    func testGeneratePathAndGetCode(){
        
        let networkManager = NetworkManager(network: MockNetwork(), networkURL: MockNetworkURL())
        networkManager.generatePathAndGetCode().subscribe(onNext: { (codeResponse) in
            XCTAssertEqual(codeResponse.responseCode, "0c9813ec-3ba8-4944-b025-5402860feebc")
        }, onError: { (error) in
            XCTFail(error.localizedDescription)
        })
        .disposed(by: disposeBag)
        
    }
    
}
