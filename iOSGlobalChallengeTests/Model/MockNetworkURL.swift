//
//  MockNetworkURL.swift
//  iOSGlobalChallengeTests
//
//  Created by Ramon Haro Marques on 17/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class MockNetworkURL:NetworkURL{

    override var nextURL: BehaviorRelay<URL?>{
        get{
            return BehaviorRelay(value: Bundle.main.url(forResource: "codeResponse", withExtension: "json"))
        }
        set{
            super.nextURL = newValue
        }
    }
    init() {
        super.init(shouldStore: false)
        
        self.baseURL = BehaviorRelay(value: Bundle.main.url(forResource: "nextPathResponse", withExtension: "json"))
        //self.nextURL = BehaviorRelay(value: Bundle.main.url(forResource: "codeResponse", withExtension: "json"))
        
    }

}
