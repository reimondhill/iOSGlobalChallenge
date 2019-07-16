//
//  CodeResponse.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


struct CodeResponse:Codable{
    
    let path:String?
    let responseCode:String?
    
    enum CodingKeys: String, CodingKey {
        case path
        case responseCode = "response_code"
    }
    
}
