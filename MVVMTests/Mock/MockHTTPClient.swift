//
//  MockHTTPClient.swift
//  MVVMTests
//
//  Created by Ravi Kumar on 30/08/23.
//

import Foundation
@testable import MVVM
class MockHTTPClient : HTTPClientProtocol {
    func request<T>(url: String, completion: @escaping (Result<T?, MVVM.NetworkError>) -> Void) where T : Decodable, T : Encodable {
        let fileURL = Bundle(for: MockHTTPClient.self).url(forResource: "user-mock", withExtension: "json")
        let data = try! Data(contentsOf: fileURL!)
        let users = try! JSONDecoder().decode(User.self, from: data)
    } 
}
