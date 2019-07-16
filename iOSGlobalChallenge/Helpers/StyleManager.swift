//
//  StyleManager.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import UIKit


extension UIColor{
    
    //MARK:- App Colors Extension
    static var accentColor:UIColor {
        return UIColor(red: 187.0/255.0, green: 25.0/255.0, blue: 25.0/255.0, alpha: 1)
    }
    
    static var defaultSeparator:UIColor {
        return UIColor.lightGray
    }
    
    static var defaultTint:UIColor{
        return mainText
    }
    
    
    //MARK: Status, Toolbar and NavigationBar
    static var statusBarBackground:UIColor{
        return accentColor
    }
    
    static var navigationBarBackground:UIColor{
        return accentColor
    }
    static var navigationBarTint:UIColor{
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    static var navigationBarText:UIColor{
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    static var toolbar:UIColor{
        return accentColor
    }
    static var toolbarTint:UIColor{
        return navigationBarTint
    }
    
    
    //MARK: Text
    static var mainText:UIColor{
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    }
    static var secondaryText:UIColor{
        return UIColor(red: 61.0/255.0, green: 61.0/255.0, blue: 61.0/255.0, alpha: 1)
    }
    
    
    //MARK: Views
    static var mainViewBackground:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    static var popupViewBackground:UIColor{
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 0.4)
    }
    
    static var primaryViewBackground:UIColor{
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static var selectionBackground:UIColor{
        return UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
    }
    
    
    //MARK: Button
    static var mainButtonBackground:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    static var mainButtonBorder:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    static var mainButtonTextColor:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    
    static var mainButtonDisabledBackground:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    static var mainButtonDisabledBorder:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    static var mainButtonDisabledTextColor:UIColor{
        return UIColor(red: 242.0/255.0, green: 239.0/255.0, blue: 236.0/255.0, alpha: 1)
    }
    
}

struct Heights {
    static var button:CGFloat{ return DeviceTraitStatus.current == .wRhR ? 64:46 }
}

struct Margins {
    
    static let xxSmall:CGFloat = 1
    static let xSmall:CGFloat = 3
    static let small:CGFloat = 4
    static let medium:CGFloat = 8
    static let large:CGFloat = 12
    static let xLarge:CGFloat = 18
    static let xxLarge:CGFloat = 24
    
}

struct TextSize {
    
    static let navigationTitle:CGFloat = 17
    
    static let title:CGFloat = DeviceTraitStatus.current == .wRhR ? 21:18
    
    static let normal:CGFloat = DeviceTraitStatus.current == .wRhR ? 18:15
    static let normalSmall:CGFloat = DeviceTraitStatus.current == .wRhR ? 16:13
    
    static let heaader:CGFloat = DeviceTraitStatus.current == .wRhR ? 42:32
    static let subHeader:CGFloat = DeviceTraitStatus.current == .wRhR ? 29:21
    
}

struct BorderRadius {
    
    static let xSmall:CGFloat = 3
    static let small:CGFloat = 5
    static let medium:CGFloat = 10
    static let large:CGFloat = 15
    static let xlarge:CGFloat = 20
    static let xxlarge:CGFloat = 25
    
}

struct Separators {
    
    static let xSmall:CGFloat = 1
    static let small:CGFloat = 3
    static let medium:CGFloat = 6
    static let large:CGFloat = 8
    static let xlarge:CGFloat = 12
    static let xxlarge:CGFloat = 15
    
}

