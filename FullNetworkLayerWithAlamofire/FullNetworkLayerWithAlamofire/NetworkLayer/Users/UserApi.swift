//
//  UserApi.swift
//  FullNetworkLayerWithAlamofire
//
//  Created by Ahmed Fayeq on 09/01/2022.
//

import Foundation

// protocol oriented
protocol UserAPIProtocol {
    func getUsers(completion: @escaping (Result<UsersResponse?, NSError>)-> Void)
}

class UserAPI: BaseApi<UserNetworking>, UserAPIProtocol{
    
    // MARK: - Requests
    
    func getUsers(completion: @escaping (Result<UsersResponse?, NSError>)-> Void){
        self.fetchData(target: .getUsers, responseClass: UsersResponse.self) { (result) in
            completion(result)
        }
    }
}

// static let shared = UserAPI()
