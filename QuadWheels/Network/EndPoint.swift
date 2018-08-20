//
//  EndPoint.swift
//  QuadWheels
//
//  Created by Jitendra on 01/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

import UIKit

enum EndPoint: String {
    
    case manufacturer   = "v1/car-types/manufacturer"
    
    case mainTypes      = "v1/car-types/main-types"
}

extension EndPoint {
    
    private var mandatoryQueryItems: [String] {              //This includes array of `mandatory` parameters, for status code 200.
        switch self {
        case .mainTypes:
            return ["manufacturer"]
        default:
            return []
        }
    }
    
    public func getMandatoryQueryItems(appending parameters: Parameters) -> [URLQueryItem] {
        
        let missingParameters = mandatoryQueryItems.filter { parameters.keys.contains($0) == false }
        
        assert(missingParameters.isEmpty, "Missing mandatory query parameters: \(missingParameters)")
                
        return parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
