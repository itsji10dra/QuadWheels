//
//  Response.swift
//  QuadWheels
//
//  Created by Jitendra on 01/08/18.
//  Copyright © 2018 Jitendra Gandhi. All rights reserved.
//

struct Response<T>: Decodable where T: Decodable {
    
    let page: UInt?
    
    let pageSize: UInt?
    
    let totalPageCount: UInt?
    
    let data: T?
    
    enum CodingKeys: String, CodingKey {
        case page
        case pageSize
        case totalPageCount
        case data = "wkda"
    }
}
