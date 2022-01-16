//
//  Helper.swift
//  StaionEbook
//
//  Created by Shekhar Deshmukh on 16/01/22.
//

import Foundation
import UIKit

class Helper{
    //Set button data
    static func makeButton(title: String? = nil,
                    titleColor: UIColor = .black,
                    font: UIFont? = nil,
                    background: UIColor = .clear,
                    cornerRadius: CGFloat = 0,
                    borderWidth: CGFloat = 0,
                    borderColor: UIColor = .clear) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.backgroundColor = background
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.layer.cornerRadius = 6.0
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }
    
    static func makeTextFeild() -> UITextField{
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter text here"
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }
    
    // to call func in backround
    static func background(work: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).async {
            work()
        }
    }
    
    // set alert with Ok button
    static func presentAlert(on viewController:UIViewController,title:String,message:String)  {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
