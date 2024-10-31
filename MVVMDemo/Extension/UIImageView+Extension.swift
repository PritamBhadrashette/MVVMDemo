//
//  UIImageView+Extension.swift
//  MVVMDemo
//
//  Created by Admin on 28/10/24.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(with urlString : String) {
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
}
