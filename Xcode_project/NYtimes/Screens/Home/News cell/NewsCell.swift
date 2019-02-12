//
//  NewsCell.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit
import AlamofireImage

class NewsCell: UITableViewCell, ReusableView {
    
    private lazy var newsContentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.0
        view.clipsToBounds = true
        view.applyShadow(style: .tiny)
        
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
       let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.applyShadow(style: .small)
        
        return label
    }()
    
    private func setupViews() {
        addSubview(newsContentView)
        newsContentView.addSubview(newsImageView)
        newsContentView.addSubview(titleLabel)
        
        newsContentView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor,
                               right: rightAnchor, topConstant: 8, leftConstant: 12,
                               bottomConstant: 8, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        newsImageView.anchor(newsContentView.topAnchor, left: newsContentView.leftAnchor, bottom: nil,
                             right: newsContentView.rightAnchor, topConstant: 0, leftConstant: 0,
                             bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 120)
        titleLabel.anchor(nil, left: newsImageView.leftAnchor, bottom: newsImageView.bottomAnchor,
                          right: newsImageView.rightAnchor, topConstant: 0, leftConstant: 12,
                          bottomConstant: 6, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        
        backgroundColor = .clear
        
    }

    func configure(with viewModel: NewsCellModel) {
        newsImageView.af_setImage(withURL: viewModel.imageUrls.first)
        titleLabel.text = viewModel.title
    }
    
    override func prepareForReuse() {
        newsImageView.af_cancelImageRequest()
        newsImageView.image = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
}
