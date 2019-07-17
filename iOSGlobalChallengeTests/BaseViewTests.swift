//
//  BaseViewTests.swift
//  iOSGlobalChallengeTests
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import XCTest

@testable import iOSGlobalChallenge


class BaseViewTests: XCTestCase {
    
    func testBaseLabel(){
        
        BaseLabel.LabelConfiguration.allCases.forEach { (labelConfiguration) in
            
            let baseLabel = BaseLabel(withConfiguration: labelConfiguration)
            switch labelConfiguration{
                
            case .navBar:
                XCTAssertEqual(baseLabel.textColor, UIColor.navigationBarText)
                XCTAssertEqual(baseLabel.font, UIFont.systemFont(ofSize: TextSize.navigationTitle, weight: .semibold))
            case .normal:
                XCTAssertEqual(baseLabel.textColor, UIColor.mainText)
                XCTAssertEqual(baseLabel.font, UIFont.systemFont(ofSize: TextSize.normal, weight: .regular))
            case .normalLight:
                XCTAssertEqual(baseLabel.textColor, UIColor.secondaryText)
                XCTAssertEqual(baseLabel.font, UIFont.systemFont(ofSize: TextSize.normal, weight: .light))
            }
            
        }
        
    }
    
    func testBaseLabelChangedConfiguration(){
        
        let baseLabel = BaseLabel(withConfiguration: .normal)
        baseLabel.labelConfiguration = .normalLight
        
        XCTAssertEqual(baseLabel.textColor, UIColor.secondaryText)
        XCTAssertEqual(baseLabel.font, UIFont.systemFont(ofSize: TextSize.normal, weight: .light))
        
    }
    
}
