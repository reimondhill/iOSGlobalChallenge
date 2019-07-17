//
//  ViewModelTests.swift
//  iOSGlobalChallengeTests
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation
import XCTest

@testable import iOSGlobalChallenge
import RxSwift
import RxCocoa
import RxTest


class ViewModelTests: XCTestCase {
    
    let disposeBag = DisposeBag()
    
    func testCodeGeneratorViewModel(){
        
        let codeGeneratorViewModel = CodeGeneratorViewModel()
        let scheduler = TestScheduler(initialClock: 0)
        
        let counterTestableObservable = scheduler.createColdObservable([.next(5, 1), .next(10, 2)])
        counterTestableObservable.bind(to: codeGeneratorViewModel.counter).disposed(by: disposeBag)
        
        let counterTestableObserver = scheduler.createObserver(String.self)
        scheduler.scheduleAt(0) {
            counterTestableObservable.map({ _ -> String in return codeGeneratorViewModel.counterFormattedString })
                .subscribe(counterTestableObserver)
                .disposed(by: self.disposeBag)
        }
        
    
        let codeTestableObservable = scheduler.createColdObservable([.next(6, "A-B-C-D"), .next(11, "D-C-B-A")])
        codeTestableObservable.bind(to: codeGeneratorViewModel.code).disposed(by: disposeBag)
        
        let codeTestableObserver = scheduler.createObserver(String.self)
        scheduler.scheduleAt(0) {
            codeTestableObservable.map({ _ -> String in return codeGeneratorViewModel.codeFormattedString })
                .subscribe(codeTestableObserver)
                .disposed(by: self.disposeBag)
        }
        
        scheduler.start()
        
        XCTAssertEqual(counterTestableObserver.events, [.next(5, "Times Fetched: 1"), .next(10, "Times Fetched: 2")])
        XCTAssertEqual(codeTestableObserver.events, [.next(6, "Response Code: A-B-C-D"), .next(11, "Response Code: D-C-B-A")])
        
    }
    
}

