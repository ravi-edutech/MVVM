//
// UsersViewController.swift
// MVVM
//
// Created by Ravi kumar BHURI SINGH on 28/06/23.
//

import UIKit

class UsersViewController: UIViewController {

    lazy var httpClientProtcolType:HTTPClientProtocol = HTTPClient()
    lazy var userPresenter: UserViewModel = UserViewModel(client: httpClientProtcolType)
    lazy var usersView = UsersView(frame: self.view.frame)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = usersView
        userPresenter.getUsers()
        userPresenter.updateUI = {users in
            print("users :: \(#line) \(users.count)")
            self.usersView.users = users
            self.usersView.listView.reloadData()
        }
    }
}



