//
//  BaseApi.swift
//  ApiWithAlamofire
//
//  Created by Ahmed Fayeq on 08/01/2022.
//

import Foundation
import Alamofire

class BaseApi<T:TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, NSError>)-> Void){
        let method  = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params  = buildParams(task: target.task)
        AF.request(target.baseURL + target.path, method: method, parameters:params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                completion(.failure(error))
                return
            }
            if statusCode == 200 {
                guard let jsonResponse = try? response.result.get() else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                guard let jsonResponseObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])
                    completion(.failure(error))
                    return
                }
                completion(.success(jsonResponseObject))
                
            }else{ // add custom error based on status code 404 / 401 notFound, unAuthorized
                let errorMsg = "Error message parsed from server"
                let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: errorMsg])
                completion(.failure(error))
            }
        }
    }
    
    
    private func buildParams(task: Task)-> ([String: Any], ParameterEncoding){
        switch task {
        case .requestPlain:
            return([:], URLEncoding.default)
        case .requestParmeters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    }
}