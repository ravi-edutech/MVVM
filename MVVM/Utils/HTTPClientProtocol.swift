//
//  HTTPClientProtocol.swift
//  MVVM
//
//  Created by Ravi Kumar on 29/08/23.
//

import Foundation

protocol HTTPClientProtocol {
    func request<T: Codable>(url:String,completion: @escaping (Result<T?, NetworkError>) -> Void)
}
