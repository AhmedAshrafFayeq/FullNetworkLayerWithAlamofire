//
//  UserApi.swift
//  FullNetworkLayerWithAlamofire
//
//  Created by Ahmed Fayeq on 09/01/2022.
//

import Foundation
import Alamofire

// protocol oriented
protocol UserAPIProtocol {
    func getUsers(completion: @escaping (Result<BaseResponse<[Datum]>?, AFError>)-> Void)
}

class UserAPI: BaseApi<UserNetworking>, UserAPIProtocol{
    
    // MARK: - Requests
    
    func getUsers(completion: @escaping (Result<BaseResponse<[Datum]>?, AFError>)-> Void){
        self.fetchData(target: .getUsers, responseClass: BaseResponse<[Datum]>.self) { (result) in
            completion(result)
        }
    }
}

// static let shared = UserAPI()
