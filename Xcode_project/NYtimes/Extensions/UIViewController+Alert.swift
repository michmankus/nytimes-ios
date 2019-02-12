//
//  UIViewController+Alert.swift
//  NYtimes
//
//  Created by Michał Mańkus on 12/02/2019.
//  Copyright © 2019 Michał Mańkus. All rights reserved.
//

import UIKit

struct AlertButtonViewModel {
    typealias AlertButtonAction = (() -> Void)
    let title: String
    let action: AlertButtonAction?
    let style: UIAlertAction.Style
    init(title: String,
         style: UIAlertAction.Style = .default,
         action: AlertButtonAction? = nil) {
        self.title = title
        self.action = action
        self.style = style
    }
    
    static let okButton: AlertButtonViewModel = AlertButtonViewModel(title: "OK")
}

struct AlertViewModel {
    let message: String
    let title: String
    let buttons: [AlertButtonViewModel]
}

extension AlertViewModel {
    static func tryAgainAlertModel(message: String,
                                   cancelAction: (() -> Void)? = nil,
                                   tryAgainAction: @escaping () -> Void) -> AlertViewModel {
        let buttons = [
            AlertButtonViewModel(title: "Cancel", style: .cancel) {
                cancelAction?()
            },
            AlertButtonViewModel(title: "Try Again") {
                tryAgainAction()
            }
        ]
        return AlertViewModel(message: message,
                              title: "Error",
                              buttons: buttons)
    }
}

extension UIViewController {
    func showAlert(using model: AlertViewModel) {
        let alert = UIAlertController(title: model.title,
                                      message: model.message,
                                      preferredStyle: .alert)
        
        model.buttons.forEach { model in
            let action = UIAlertAction(
                title: model.title,
                style: model.style) { action in
                    model.action?()
            }
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
