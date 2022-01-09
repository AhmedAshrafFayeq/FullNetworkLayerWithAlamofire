//
//  UserNetworking.swift
//  ApiWithAlamofire
//
//  Created by Ahmed Fayeq on 08/01/2022.
//

import Foundation
import Alamofire

enum UserNetworking {
    case getUsers
    case createUser(name: String, job: String)
}

extension UserNetworking: TargetType{
    var baseURL: String {
        switch self {
        default:
            return Constants.baseUrl
        }
    }
    
    var path: String {
        switch self {
        case .getUsers:
            return Constants.usersApi       //   "/users"
        case .createUser:
            return Constants.usersApi
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUsers:
            return .get
        case .createUser:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getUsers:
            return .requestPlain
        case .createUser(name: let name, job: let job):
            return .requestParmeters(parameters: ["name": name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
}
