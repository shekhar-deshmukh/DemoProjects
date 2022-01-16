//
//  TableViewExtension.swift
//  StaionEbook
//
//  Created by Shekhar Deshmukh on 16/01/22.
//

import Foundation
import UIKit

extension UITableView {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            let activityView = UIActivityIndicatorView(style: .large)
            self.backgroundView = activityView
            activityView.startAnimating()
        }
    }
    
    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
