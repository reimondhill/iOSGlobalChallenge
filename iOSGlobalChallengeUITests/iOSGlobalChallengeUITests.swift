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
        //Uncomment next line to use MOCKNetwork for the app
        app.launchArguments = ["TEST"]
        app.launch()
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testCodeGeneratorView(){
        
        let codeGeneratorView = app.otherElements["CodeGeneratorView"]
        
        let codeLabel = codeGeneratorView.staticTexts["CodeLabel"]
        let counterLabel = codeGeneratorView.staticTexts["CounterLabel"]
        let activityIndicator = codeGeneratorView.activityIndicators.element(boundBy: 0)
        let generateButton = codeGeneratorView.buttons["GenerateButton"]
        
        XCTAssert(codeLabel.exists && counterLabel.exists && generateButton.exists)
        XCTAssertFalse(activityIndicator.exists)
        
        XCTAssertEqual(codeLabel.label, "Response Code: Not available")
        XCTAssertEqual(counterLabel.label, "Times Fetched: 0")
        
        generateButton.tap()
        
        expectation(for: getLabelPredicate(text: String(format: "Response Code: %@", "0c9813ec-3ba8-4944-b025-5402860feebc")), evaluatedWith: codeLabel, handler: nil)
        expectation(for: getLabelPredicate(text: String(format: "Times Fetched: %d", 1)), evaluatedWith: counterLabel, handler: nil)
        
        waitForExpectations(timeout: 5, handler: nil)
        
    }
    
    func getLabelPredicate(text:String) -> NSPredicate{
        return NSPredicate(format: "label BEGINSWITH '\(text)'")
    }

}
