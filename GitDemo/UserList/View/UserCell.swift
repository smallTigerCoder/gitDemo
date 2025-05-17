//
//  UserCell.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

class UserCell: UITableViewCell {
    private let userImageView = UIImageView()
    private let usernameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layoutUI() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(userImageView)
        
        userImageView.backgroundColor = .clear
        userImageView.contentMode = .scaleAspectFill
        usernameLabel.font = UIFont.systemFont(ofSize: 16,weight: .medium)
        usernameLabel.textColor = .black
        
        userImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
        usernameLabel.snp.makeConstraints { make in
            make.left.equalTo(userImageView.snp.right).offset(12)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
    }
    func configure(with user: UserModel) {
        usernameLabel.text = user.login
        userImageView.setAvatar(with: user.avatar_url)
    }
}
