//
//  ViewController.swift
//  StaionEbook
//
//  Created by Shekhar Deshmukh on 16/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var textField =  UITextField()
    var button = UIButton()
    private var navigationHandler: NavigationHandler?

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        setupTextField()
        setupButton()
    }
    
    // Set TextField
    func setupTextField() {
        self.textField = Helper.makeTextFeild()
        self.view.addSubview(textField)
        setupTextFieldConstain()
    }
    
    // Set textfield constraint
    func setupTextFieldConstain(){
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
    }
    
    // Set Button
    func setupButton(){
        self.button = Helper.makeButton(title: "Submit", titleColor: .black, font: UIFont.init(name: "Arial", size: 18.0), background: .white, cornerRadius: 3.0, borderWidth: 1, borderColor: .black)
        view.addSubview(button)
        //set constraint
        setupButtonConstraint()
        //add button press action
        button.addTarget(self, action: #selector(pressed(_ :)), for: .touchUpInside)
    }
    
    func setupButtonConstraint(){
        // Adding Constraints
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 70).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -70).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
    }
    
    // Button Action
    @objc func pressed(_ sender: UIButton) {
        // present detail view
        let detailViewController = DetailViewController()
        detailViewController.myUrl = textField.text ?? ""
        self.navigationHandler = NavigationHandler(controller: detailViewController)
        self.present(detailViewController, animated: true, completion: nil)
    }
}

