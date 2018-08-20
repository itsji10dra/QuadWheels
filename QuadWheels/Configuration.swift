//
//  Configuration.swift
//  QuadWheels
//
//  Created by Jitendra on 01/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

struct Configuration {
    
    static let url      = "http://api-aws-eu-qa-1.auto1-test.com/"
 
    static let apiKey   = "coding-puzzle-client-449cc9d"
    
    static let pageSize = 15
    
    static func checkConfiguration() {
        
        if url.isEmpty || apiKey.isEmpty || pageSize < 0 {
            fatalError("""
                Invalid configuration found.
            """)
        }
    }
}

struct UIConfiguration {

    static let evenCellColor = UIColor(red: 223/255, green: 228/255, blue: 234/255, alpha: 1.0)

    static let oddCellColor = UIColor(red: 241/255, green: 242/255, blue: 246/255, alpha: 1.0)
    
    static let activityIndicatorColor = UIColor(red: 183/255, green: 21/255, blue: 64/255, alpha: 1.0)
    
    static let cellHeight: CGFloat = 55
}
