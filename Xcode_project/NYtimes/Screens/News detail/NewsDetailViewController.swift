//
//  NewsDetailViewController.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    private let myView: NewsDetailView
    private let viewModel: NewsDetailViewModel
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureUI() {
        myView.headerImageView.hero.id = viewModel.headerImageHeroID
        myView.headerImageView.af_setImage(withURL: viewModel.headerImageURL)
        myView.titleLabel.hero.id = viewModel.titleLabelHeroID
        myView.titleLabel.text = viewModel.titleText
        myView.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        myView.contentTextView.text = viewModel.articleText
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    override func loadView() {
        view = myView
    }
    
    init(viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        self.myView = NewsDetailView()
        
        super.init(nibName: nil, bundle: nil)

        hero.isEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsDetailViewController {
    @objc private func closeButtonAction() {
        viewModel.closeButtonAction()
    }
}
