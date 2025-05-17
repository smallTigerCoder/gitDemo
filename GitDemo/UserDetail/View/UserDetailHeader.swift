//
//  UserDetailHeader.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import UIKit
import SnapKit

class UserDetailHeader: UIView {
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var companyLabel: IconLabel = {
        let label = IconLabel(icon: "building.2", text: "")
           return label
    }()
    
    private lazy var locationLabel: IconLabel = {
        let label = IconLabel(icon: "mappin.and.ellipse", text: "")
           return label
    }()
    
    private lazy var repoLabel: IconLabel = {
        let label = IconLabel(icon: "folder", text: "")
        return label
    }()
    
    private lazy var followersLabel: IconLabel = {
        let label = IconLabel(icon: "person.2", text: "")
        return label
    }()
    
    private lazy var followingLabel: IconLabel = {
        let label = IconLabel(icon: "person.crop.circle.badge.checkmark", text: "")
        return label
    }()

    private lazy var infoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        [companyLabel, locationLabel, repoLabel, followersLabel, followingLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutUI() {
        backgroundColor = .white
        
        addSubview(userImageView)
        addSubview(nameLabel)
        addSubview(loginLabel)
        addSubview(infoStack)
        
        // Add a separator line at the bottom of the header
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(white: 0.9, alpha: 1)
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        userImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(16)
            make.width.height.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImageView)
            make.left.equalTo(userImageView.snp.right).offset(12)
            make.right.equalToSuperview().offset(-16)
        }
        
        loginLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.equalTo(nameLabel)
        }
        
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(12)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // Assign values to UI elements
    func configureUI(with detail: UserDetailModel) {
        userImageView.setImage(with: detail.avatarUrl)
        nameLabel.text = detail.name ?? "No Name"
        loginLabel.text = "@\(detail.login ?? "unknown")"
        companyLabel.setText(detail.company ?? "No company")
        locationLabel.setText(detail.location ?? "No location")
        repoLabel.setText("Public Repos: \(detail.publicRepos ?? 0)")
        followersLabel.setText("Followers: \(detail.followers ?? 0)")
        followingLabel.setText("Following: \(detail.following ?? 0)")
    }
}


