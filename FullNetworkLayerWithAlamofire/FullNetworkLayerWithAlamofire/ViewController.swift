//
//  ViewController.swift
//  FullNetworkLayerWithAlamofire
//
//  Created by Ahmed Fayeq on 08/01/2022.
//

import UIKit

class ViewController: UIViewController {

    var api: UserAPIProtocol = UserAPI()
    var users: [Datum] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getUsers()
    }
    
    func getUsers(){
        api.getUsers(completion: { [weak self] (result) in
            guard let self = self else{return}
            
            switch result{
            case .success(let response):
                guard let response = response else{return}
                self.users = response.data
                for user in self.users{
                    print(user.employeeName)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
}
