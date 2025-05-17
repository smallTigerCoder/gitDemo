//
//  UIImageView+Kingfisher.swift
//  GitDemo
//
//  Created by echo on 2025/5/14.
//

import Foundation
import Kingfisher

extension UIImageView {
    
    func setImage(with urlString: String?,placehoder: String = "placehoder") {
        guard let urlStr = urlString, let url = URL(string: urlStr) else {
            self.image = UIImage(named: placehoder)
            return
        }
        self.kf.setImage(
            with: url,
        placeholder: UIImage(named: placehoder),
        options: [
            .transition(.fade(0.2)),
            .cacheOriginalImage
        ])
    }
    
    // Load round avatar
    func setAvatar(with urlString: String?, placehodler: String = "placehoder") {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        setImage(with: urlString, placehoder: placehodler)
    }
}
