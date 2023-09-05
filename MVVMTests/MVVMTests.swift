//
//  MVVMTests.swift
//  MVVMTests
//
// Created by Ravi kumar on 28/06/23.
//

import XCTest
@testable import MVVM

final class MVVMTests: XCTestCase {
    var usersVC:UsersViewController! = nil
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        usersVC = UsersViewController()
        usersVC.httpClientProtcolType = MockHTTPClient()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testUserRequest(){
        let presenter = UserPresenter(client: usersVC.httpClientProtcolType)
        usersVC.userPresenter = presenter
        let fileURL = Bundle(for: MVVMTests.self).url(forResource: "user-mock", withExtension: "json")
        let data = try! Data(contentsOf: fileURL!)
//        usersVC.fetchUsers()
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
