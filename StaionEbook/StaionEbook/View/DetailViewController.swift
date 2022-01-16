//
//  DetailViewController.swift
//  StaionEbook
//
//  Created by Shekhar Deshmukh on 16/01/22.
//

import UIKit
import Foundation

class DetailViewController: UIViewController {
 
    var posts = NSMutableArray()
    let tableView = UITableView()
    var safeArea: UILayoutGuide!
    var myUrl = ""
    let dataHandler = DataHandler()
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        dataHandler.delegate = self
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.showActivityIndicator()
        Helper.background {
             // fetch data
            self.dataHandler.getParseXMLdata(url:self.myUrl)
        }
    }

    // Set TableView
    func setupTableView() {
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.clipsToBounds = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        setupTableviewConstrains()
    }
    //Set TableView Constrains
    func setupTableviewConstrains(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 5).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let dico = posts[indexPath.row]
        // set label data
        let stationName = (dico as! NSMutableDictionary).object(forKey:"StationName") as? String ?? ""
        let stationId = (dico as! NSMutableDictionary).object(forKey:"StationId") as? String ?? ""
        let str = "\(stationName)\n\(stationId)"
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = str
        // set imageview data
        let url = (dico as! NSMutableDictionary).object(forKey:"Logo") as? String ?? "http://item.radio456.com/007452/logotv/logo-87007.jpg"
        cell.imageView?.imageFromServerURL(urlString: url, PlaceHolderImage: UIImage.init(named: "placeholder")!)
        
        return cell
    }
}

extension DetailViewController : DataHandlerDelegate{
    func getParseXMLdataResopnce(data: NSMutableArray) {
        DispatchQueue.main.async {
            self.tableView.hideActivityIndicator()
            self.posts = data
            self.posts.removeObject(at: 0)
            self.tableView.reloadData()
        }
    }
    
    func onError(errorMsg: String) {
        DispatchQueue.main.async {
            self.tableView.hideActivityIndicator()
            Helper.presentAlert(on: self, title: "Alert", message: errorMsg)
        }
    }
}
