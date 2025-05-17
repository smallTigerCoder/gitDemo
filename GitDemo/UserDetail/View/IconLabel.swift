//
//  IconLabel.swift
//  GitDemo
//
//  Created by echo on 2025/5/15.
//

import UIKit

class IconLabel: UIView {
    private let iconView = UIImageView()
    private let textLabel = UILabel()
    
    init(icon: String, text: String) {
        super.init(frame: .zero)
        setupUI(icon: icon, text: text)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI(icon: "", text: "")
    }
    
    private func setupUI(icon: String, text: String) {
        iconView.image = UIImage(systemName: icon)
        iconView.tintColor = .gray
        iconView.contentMode = .scaleAspectFit
        iconView.snp.makeConstraints { $0.width.height.equalTo(20) }

        textLabel.text = text
        textLabel.font = .systemFont(ofSize: 16)
        textLabel.textColor = .darkGray

        let stack = UIStackView(arrangedSubviews: [iconView, textLabel])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.alignment = .center
        
        addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setText(_ text: String) {
        textLabel.text = text
    }
}
