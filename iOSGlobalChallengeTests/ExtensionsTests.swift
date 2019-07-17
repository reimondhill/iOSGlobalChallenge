//
//  ExtensionsTests.swift
//  iOSGlobalChallengeTests
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import XCTest
@testable import iOSGlobalChallenge


class MockClass:NSObject{}

class ExtensionsTests: XCTestCase {
    
    //MARK:- NSObjectExtension
    func testNSObjectLogClassName(){
        
        let mockClass = MockClass()
        XCTAssertEqual(mockClass.logClassName,"MockClass:")
        XCTAssertEqual(MockClass.logClassName,"MockClass:")
        
    }
    
    func testNSObjectIdentifier(){
        
        let mockClass = MockClass()
        XCTAssertEqual(mockClass.identifier, "MockClass")
        XCTAssertEqual(MockClass.identifier, "MockClass")
        
    }
    
    
    //MARK:- UIButtonExtension
    func testUIButtonBackgroun(){
        
        let baseButton = BaseButton(withConfiguration: .normal)
        
        baseButton.setBackgroundColor(.red, for: .normal)
        //TODO
        
    }
    
    
    
    //MARK:- UIEdgeInsetsExtension
    func testUIEdgeInsetsInit(){
        
        let inset = UIEdgeInsets(padding: 12)
        
        XCTAssertEqual(inset.top, 12)
        XCTAssertEqual(inset.top, inset.left)
        XCTAssertEqual(inset.top, inset.bottom)
        XCTAssertEqual(inset.top, inset.right)
    }
    
    
    //MARK:- UINavigationControllerExtension
    func testPreferredStatusStyle(){
        
        let navigationController = UINavigationController(rootViewController: UIViewController())
        XCTAssertEqual(navigationController.preferredStatusBarStyle, .lightContent)
        
        
    }
    
    
    //MARK:- UIViewControllerExtension
    func testUIViewControllerCurrentTraitStatus(){
        
        let viewController = UIViewController()
        
        switch (UIScreen.main.traitCollection.horizontalSizeClass, UIScreen.main.traitCollection.verticalSizeClass){
            
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.regular):
            return XCTAssertEqual(viewController.currentTraitStatus, .wRhR)
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.regular):
            return XCTAssertEqual(viewController.currentTraitStatus, .wChR)
        case (UIUserInterfaceSizeClass.regular, UIUserInterfaceSizeClass.compact):
            return XCTAssertEqual(viewController.currentTraitStatus, .wRhC)
        case (UIUserInterfaceSizeClass.compact, UIUserInterfaceSizeClass.compact):
            return XCTAssertEqual(viewController.currentTraitStatus, .wChC)
            
        default:
            break
        }
        
    }
    
    
    //MARK:- UIViewExtension
    func testUIViewConstraintToSuperViewEdges(){
        
        let containerView = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        
        let innerView = UIView()
        containerView.addSubview(innerView)
        let anchoredConstraints = innerView.constraintToSuperViewEdges()
        
        XCTAssert(innerView.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(anchoredConstraints != nil)
        XCTAssert(anchoredConstraints?.top != nil && anchoredConstraints?.trailing != nil && anchoredConstraints?.bottom != nil && anchoredConstraints?.leading != nil)
        
    }
    
    func testUIViewAnchor(){
        
        let containerView = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        
        let innerView = UIView()
        containerView.addSubview(innerView)
        let anchoredConstraints = innerView.anchor(top: containerView.topAnchor,
                                                   leading: containerView.leadingAnchor,
                                                   bottom: containerView.bottomAnchor,
                                                   trailing: containerView.trailingAnchor,
                                                   size: .init(width: 0, height: 0))
        
        XCTAssert(innerView.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(anchoredConstraints.top != nil && anchoredConstraints.trailing != nil && anchoredConstraints.bottom != nil && anchoredConstraints.leading != nil)
        XCTAssert(anchoredConstraints.width == nil && anchoredConstraints.height == nil)
        
        
    }
    
    func testCenterInSuperview(){
        
        let containerView = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        
        let innerView = UIView()
        containerView.addSubview(innerView)
        let anchoredConstraints = innerView.centerInSuperview(size: .init(width: 25, height: 25))
        
        XCTAssert(innerView.translatesAutoresizingMaskIntoConstraints == false)
        XCTAssert(anchoredConstraints.top == nil && anchoredConstraints.trailing == nil && anchoredConstraints.bottom == nil && anchoredConstraints.leading == nil)
        XCTAssert(anchoredConstraints.width != nil && anchoredConstraints.height != nil)
        XCTAssert(anchoredConstraints.centerX != nil && anchoredConstraints.centerY != nil)
        
        
    }
    
    func testUIViewBorders(){
        
        let directions:[Direction] = [.up, .left, .down, .right]
        let view = UIView(frame: CGRect(origin: .zero, size: .init(width: 50, height: 50)))
        let color = UIColor.red
        let size:CGFloat = 1
        
        for direction in directions{
            var borderView:UIView = UIView()
            
            switch direction{
            case .up:
                borderView = view.addTopSeparator(color: color, height: size, margins: 0)
            case .left:
                borderView = view.addLeftSeparator(color: color, width: size, margins: 0)
            case .down:
                borderView = view.addBottomSeparator(color: color, height: size, margins: 0)
            case .right:
                borderView = view.addRightSeparator(color: color, width: size, margins: 0)
            default:
                return
                
            }
            
            XCTAssertEqual(borderView.backgroundColor, color)
            XCTAssertEqual(borderView.superview, view)
            
        }
        
    }
    
    func testUIViewParentViewController(){
        
        let viewController = UIViewController()
        let aView = UIView()
        viewController.view.addSubview(aView)
        
        XCTAssert(aView.viewControler != nil)
        XCTAssertEqual(aView.viewControler, viewController)
        
        XCTAssert(aView.findViewController() != nil)
        XCTAssertEqual(aView.findViewController(), viewController)
        
    }
    
}
