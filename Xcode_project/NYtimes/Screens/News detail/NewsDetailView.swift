//
//  NewsDetailView.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

class NewsDetailView: UIView {
    
    lazy var headerImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.accessibilityIdentifier = "newsDetailHeaderImageView"
        return imageView
    }()
    
    lazy var titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        
        return label
    }()
    
    lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "closeButton")
        button.setImage(image, for: .normal)
        button.accessibilityIdentifier = "closeButton"
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        accessibilityIdentifier = "newsDetailView"
        backgroundColor = .white
        
        addSubview(headerImageView)
        addSubview(contentTextView)
        addSubview(closeButton)
        headerImageView.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(titleLabel)
        headerImageView.anchor(topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor,
                               topConstant: 0, leftConstant: 0, bottomConstant: 0,
                               rightConstant: 0, widthConstant: 0, heightConstant: 200)
        titleBackgroundView.anchor(nil, left: headerImageView.leftAnchor, bottom: headerImageView.bottomAnchor,
                                   right: headerImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0,
                                   rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleLabel.anchor(titleBackgroundView.topAnchor, left: titleBackgroundView.leftAnchor,
                          bottom: titleBackgroundView.bottomAnchor, right: titleBackgroundView.rightAnchor,
                          topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        contentTextView.anchor(headerImageView.bottomAnchor, left: safeAreaLayoutGuide.leftAnchor,
                               bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor,
                               topConstant: 16, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        closeButton.anchor(safeAreaLayoutGuide.topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil,
                           topConstant: 0, leftConstant: 12, bottomConstant: 0,
                           rightConstant: 0, widthConstant: 40, heightConstant: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
