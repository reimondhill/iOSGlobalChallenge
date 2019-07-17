//
//  iOSGlobalChallengeUITests.swift
//  iOSGlobalChallengeUITests
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import XCTest

class iOSGlobalChallengeUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUp() {
        
        continueAfterFailure = true
        
        app = XCUIApplication()
        //TODO
        //Uncomment next line to use MOCKNetwork for the app
        //app.launchArguments = ["TEST"]
        app.launch()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCodeGeneratorView(){
        
        let codeGeneratorView = app.otherElements["CodeGeneratorView"]
        let codeLabel = codeGeneratorView.staticTexts["CodeLabel"]
        let activityIndicator = codeGeneratorView.activityIndicators.element(boundBy: 0)
        
        XCTAssert(codeLabel.exists)
        XCTAssertFalse(activityIndicator.exists)
        
        //TODO
    }

}
