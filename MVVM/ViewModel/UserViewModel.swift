//
// UserViewModel.swift
// MVVM
//
// Created by Ravi kumar on 28/06/23.
//


import Foundation
import UIKit

class UserViewModel {
    
    private let httpClient:HTTPClientProtocol?
    var updateUI:((_ users:[User]) -> Void)?
    init(client: HTTPClientProtocol) {
        httpClient = client
    }
    
    func getUsers() {
        httpClient?.request(url: Constants.URLConstants.users) { [weak self] (result:Result<UserData?,NetworkError>) in
            switch result {
            case .success(let users):
                if let users = users {
                    DispatchQueue.main.async {
                        self?.updateUI?(users.users)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        } 
    }
    
}
