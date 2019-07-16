//
//  CodeGeneratorViewModel.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 16/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class CodeGeneratorViewModel: NSObject {
    
    //MARK:- Properties
    //MARK: Constants
    let code:BehaviorRelay<String?> = BehaviorRelay(value: nil)
    let counter:BehaviorRelay<Int> = BehaviorRelay(value: 0)
    let isFetching = BehaviorRelay(value: false)
    
    
    //MARK: Variables
    var codeFormattedString:String{
        return String(format: NSLocalizedString("messages.responseCode", comment: ""), code.value ?? NSLocalizedString("messages.notAvailable", comment: ""))
    }
    var counterFormattedString:String{
        return String(format: NSLocalizedString("messages.timesFetched", comment: ""), counter.value)
    }
    
}
