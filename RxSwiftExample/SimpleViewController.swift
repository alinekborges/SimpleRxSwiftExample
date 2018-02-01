//
//  SimpleViewController.swift
//  RxSwiftExample
//
//  Created by Aline Borges on 01/02/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let countries = ["Argentina", "Bolívia", "Brasil", "Chile", "Colômbia", "Equador", "Guiana", "Paraguai", "Peru", "Suriname", "Uruguai", "Venezuela"]
    var filtered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.becomeFirstResponder()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        
        self.filtered = countries.filter {
            $0.lowercased().contains(textField.text!.lowercased())
        }
        self.tableView.reloadData()
        
    }
}

extension SimpleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countryCell", for: indexPath) as! CountryTableViewCell
        
        let item = filtered[indexPath.row]
        
        cell.bind(text: item)
        
        return cell
    }
    
}



