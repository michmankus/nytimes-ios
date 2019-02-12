//
//  UIImageView+Alamofire.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

extension UIImageView {
    public func af_setImage(withURL url: URL?, placeholderImage: UIImage? = nil) {
        guard let url = url else {
            self.image = placeholderImage
            return
        }
        
        af_setImage(withURL: url)
    }
}
