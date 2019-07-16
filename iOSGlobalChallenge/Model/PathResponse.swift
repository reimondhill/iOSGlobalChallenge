//
//  PathResponse.swift
//  iOSGlobalChallenge
//
//  Created by Ramon Haro Marques on 15/07/2019.
//  Copyright © 2019 Reimond Hill. All rights reserved.
//

import Foundation


struct PathResponse:Codable{
    
    let nextPath:String?
    
    enum CodingKeys: String, CodingKey {
        case nextPath = "next_path"
    }
    
}
