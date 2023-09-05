//
// UserCell.swift
// MVVM
//
// Created by Ravi kumar on 28/06/23.
//


import UIKit

class UserCell: UITableViewCell {

    let userLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

        var item: User? {
        didSet {
            guard let item = item else { return }
            setItem(item: item.firstName + " " + item.lastName)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .white
        selectionStyle = .gray
        contentView.addSubview(userLabel)

        let padding: CGFloat = 10

        NSLayoutConstraint.activate([
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            userLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: userLabel.bottomAnchor, constant: padding)
        ])
    }

    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setItem( item: String) {
        userLabel.text = item
    }
}

