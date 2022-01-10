//
//  BaseApi.swift
//  ApiWithAlamofire
//
//  Created by Ahmed Fayeq on 08/01/2022.
//

import Foundation
import Alamofire

class BaseApi<T:TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Result<M?, AFError>)-> Void){
        let method  = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params  = buildParams(task: target.task)
        AF.request(target.baseURL + target.path, method: method, parameters:params.0, encoding: params.1, headers: headers).responseDecodable { (response: DataResponse<M, AFError>) in
            
            switch response.result {
            case .success(let jsonResponseObject):
                completion(.success(jsonResponseObject))
            case .failure(let error):
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



//let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericError])

//.responseDecodable { (response: DataResponse<M, AFError>) in


//.responseJSON { (response) in
//    guard let statusCode = response.response?.statusCode else {
//        completion(.failure(.unableToComplete))
//        return
//    }
//    if statusCode == 200 {
//        guard let jsonResponse = try? response.result.get() else {
//            completion(.failure(.invalidResponse))
//            return
//        }
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
//            completion(.failure(.invalidData))
//            return
//        }
//        guard let jsonResponseObject = try? JSONDecoder().decode(M.self, from: jsonData) else {
//            completion(.failure(.invalidData))
//            return
//        }
//        //success
//        completion(.success(jsonResponseObject))
//
//    }else{ // add custom error based on status code 404 / 401 notFound, unAuthorized
//        completion(.failure(.invalidData))
//    }
//}
