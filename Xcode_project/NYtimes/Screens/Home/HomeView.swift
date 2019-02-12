//
//  HomeView.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

class HomeView: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.registerCell(NewsCell.self)
        view.rowHeight = 280
        view.accessibilityIdentifier = "newsFeedTableView"
        
        return view
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        backgroundColor = ColorPallete.backgroundWhite
        
        addSubview(tableView)
        tableView.fillSuperview()
        accessibilityIdentifier = "newsFeedView"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
