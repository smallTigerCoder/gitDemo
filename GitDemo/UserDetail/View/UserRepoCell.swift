//
//  UserRepoCell.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import UIKit
import SnapKit

class UserRepoCell: UITableViewCell {
    
    private let nameLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let starLabel = UILabel()
    private let forkLabel = UILabel()
    private let languageLabel = UILabel()
    private let updateDateLabel = UILabel()
    private let licenseLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        [nameLabel, descriptionLabel, starLabel, forkLabel, languageLabel, updateDateLabel, licenseLabel].forEach {
            $0.font = .systemFont(ofSize: 16)
            $0.textColor = .darkText
            $0.numberOfLines = 0
            contentView.addSubview($0)
        }
        
        nameLabel.font = .boldSystemFont(ofSize: 16)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.left.right.equalTo(nameLabel)
        }
        
        let infoStack = UIStackView(arrangedSubviews: [starLabel, forkLabel, languageLabel])
        infoStack.axis = .horizontal
        infoStack.spacing = 16
        infoStack.distribution = .equalSpacing
        contentView.addSubview(infoStack)
        
        // Add a separator line at the bottom of the cell
        let separator = UIView()
        separator.backgroundColor = UIColor(white: 0.9, alpha: 1)
        contentView.addSubview(separator)
        separator.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        infoStack.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(6)
            make.left.right.equalTo(nameLabel)
        }
        
        updateDateLabel.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
        }
        
        licenseLabel.snp.makeConstraints { make in
            make.centerY.equalTo(updateDateLabel)
            make.left.equalTo(updateDateLabel.snp.right).offset(16)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(with repo: UserRepoModel) {
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description ?? "No description"
        starLabel.attributedText = iconText(named: "star", text: "\(repo.stargazersCount)")
        forkLabel.attributedText = iconText(named: "tuningfork", text: "\(repo.forksCount)")
        languageLabel.text = repo.language ?? "Unknown"
        updateDateLabel.text = "Updated: \(formatDate(repo.updatedAt))"
        licenseLabel.text = repo.license?.name ?? ""
    }
    
    // Generate attributed text with an icon
    private func iconText(named systemName: String, text: String) -> NSAttributedString {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: systemName)?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: 14, height: 14)
        
        let attributedString = NSMutableAttributedString(attachment: imageAttachment)
        attributedString.append(NSAttributedString(string: " \(text)", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.darkText
        ]))
        return attributedString
    }
    
    // Format the date string
    private func formatDate(_ isoString: String) -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: isoString) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "yyyy-MM-dd"
            return displayFormatter.string(from: date)
        }
        return isoString
    }
}


