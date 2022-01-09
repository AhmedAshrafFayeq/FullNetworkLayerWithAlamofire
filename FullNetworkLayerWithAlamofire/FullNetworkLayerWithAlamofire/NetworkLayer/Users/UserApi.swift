//
//  UserApi.swift
//  FullNetworkLayerWithAlamofire
//
//  Created by Ahmed Fayeq on 09/01/2022.
//

import Foundation

// protocol oriented
protocol UserAPIProtocol {
    func getUsers(completion: @escaping (Result<BaseResponse<[Datum]>?, APError>)-> Void)
}

class UserAPI: BaseApi<UserNetworking>, UserAPIProtocol{
    
    // MARK: - Requests
    
    func getUsers(completion: @escaping (Result<BaseResponse<[Datum]>?, APError>)-> Void){
        self.fetchData(target: .getUsers, responseClass: BaseResponse<[Datum]>.self) { (result) in
            completion(result)
        }
    }
}

// static let shared = UserAPI()
