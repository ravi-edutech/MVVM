//
// UsersView.swift
// MVVM
//
// Created by Ravi kumar on 28/06/23.
//


import Foundation
import UIKit

class UsersView: UIView {
    
    lazy var listView: UITableView = {
        let view = UITableView()
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.separatorStyle = .singleLine
        view.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        view.rowHeight = UITableView.automaticDimension
        view.estimatedRowHeight = 100
        view.backgroundColor = .white
        view.register(UserCell.self, forCellReuseIdentifier: "userCell")
        return view
    }()
    
    var safeArea: UILayoutGuide!
    var users: [User] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.backgroundColor = .white
        self.configure()
        self.listView.reloadData()
    }
    
    required init? (coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.backgroundColor = .clear
        safeArea = self.layoutMarginsGuide
        self.addSubview(listView)
        NSLayoutConstraint.activate([
            listView.leadingAnchor.constraint (equalTo: self.leadingAnchor),
            listView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            listView.leftAnchor.constraint(equalTo: self.leftAnchor),
            listView.rightAnchor.constraint(equalTo: self.rightAnchor),
            listView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            listView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
extension UsersView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        cell.item = users[indexPath.row]
        return cell
    }
}


