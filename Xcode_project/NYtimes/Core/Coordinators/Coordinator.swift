//
//  Coordinator.swift
//  NYtimes
//
//  Created by Michał Mańkus on 11/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var appContext: AppContext { get }
    func start()
}
