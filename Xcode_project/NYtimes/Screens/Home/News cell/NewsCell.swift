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
        
        view.backgroundColor = .clear
        
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
       let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 5.0
        view.clipsToBounds = true
        
        return view
    }()
    
    private lazy var titleBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        
        return label
    }()
    
    private lazy var readMoreLabel: UILabel = {
       let label = UILabel()
        
        label.layer.cornerRadius = 5.0
        label.layer.backgroundColor = ColorPallete.oceanBlue.cgColor
        label.textAlignment = .center
        label.text = "Read more..."
        label.applyShadow(style: .floating)
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .white
        
        return label
    }()
    
    private func setupViews() {
        addSubview(newsContentView)
        newsContentView.addSubview(newsImageView)
        newsContentView.addSubview(readMoreLabel)
        newsImageView.addSubview(titleBackgroundView)
        titleBackgroundView.addSubview(titleLabel)
        
        newsContentView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor,
                               right: rightAnchor, topConstant: 8, leftConstant: 12,
                               bottomConstant: 8, rightConstant: 12, widthConstant: 0, heightConstant: 0)
        newsImageView.anchor(newsContentView.topAnchor, left: newsContentView.leftAnchor, bottom: newsContentView.bottomAnchor,
                             right: newsContentView.rightAnchor, topConstant: 0, leftConstant: 0,
                             bottomConstant: 30, rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleBackgroundView.anchor(nil, left: newsImageView.leftAnchor, bottom: newsImageView.bottomAnchor,
                                   right: newsImageView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0,
                                   rightConstant: 0, widthConstant: 0, heightConstant: 0)
        titleLabel.anchor(titleBackgroundView.topAnchor, left: titleBackgroundView.leftAnchor,
                          bottom: titleBackgroundView.bottomAnchor, right: titleBackgroundView.rightAnchor,
                          topConstant: 8, leftConstant: 8, bottomConstant: 15, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        readMoreLabel.anchor(newsImageView.bottomAnchor, left: nil, bottom: nil, right: newsImageView.rightAnchor,
                              topConstant: -12, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 30)
        
        backgroundColor = .clear
        
    }

    func configure(with viewModel: NewsCellModel) {
        newsImageView.af_setImage(withURL: viewModel.imageUrls.first)
        newsImageView.hero.id = viewModel.newsImageHeroID
        titleLabel.text = viewModel.title
        titleLabel.hero.id = viewModel.newsTitleHeroID
    }
    
    override func prepareForReuse() {
        newsImageView.af_cancelImageRequest()
        newsImageView.image = nil
    }
    
    private func commonInit() {
        selectionStyle = .none
        setupViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
}
