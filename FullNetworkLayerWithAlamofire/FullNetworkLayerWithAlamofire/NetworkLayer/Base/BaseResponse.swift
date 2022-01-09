//
//  BaseResponse.swift
//  FullNetworkLayerWithAlamofire
//
//  Created by Ahmed Fayeq on 09/01/2022.
//

import Foundation

struct BaseResponse<T:Codable>: Codable {
    var status: String
    var data: T
    
    enum codingKeys: String,CodingKey{
        case status = "status"
        case data = "data"
    }
}
