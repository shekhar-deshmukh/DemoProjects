//
//  NavigationController.swift
//  StaionEbook
//
//  Created by Shekhar Deshmukh on 16/01/22.
//

import Foundation
import UIKit

class NavigationHandler : NSObject, UIViewControllerTransitioningDelegate, UINavigationBarDelegate {
    private var isPresenting: Bool = false
    private weak var controller: UIViewController?
    
    // initiate
    init(controller: UIViewController) {
        super.init()
        
        self.controller = controller
        controller.transitioningDelegate = self
        
        let navigationBar = UINavigationBar()
        controller.view.addSubview(navigationBar)
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: controller.view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: controller.view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: controller.view.safeAreaLayoutGuide.topAnchor)
        ])
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        navigationBar.delegate = self
        
        let item = UINavigationItem(title: controller.title ?? "")
        let barButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(onBackButton(button:)))
        
        item.leftBarButtonItems = [barButton]
        navigationBar.setItems([item], animated: true)
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    // back button action
    @objc
    private func onBackButton(button: UIBarButtonItem) {
        self.controller?.dismiss(animated: true, completion: nil)
    }
    
}
