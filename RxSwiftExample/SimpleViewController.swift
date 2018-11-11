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
    
    let service: CountryService = FakeCountryService()
    let searcher: CountrySearchable = CountrySearcher()
    
    var countries: [String] = []
    var filtered: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()
        self.downloadCountries()
    }
    
    func downloadCountries() {
        self.service.getCountries { [weak self] countries in
            self?.countries = countries
        }
    }

    @IBAction func textFieldDidChange(_ sender: Any) {
        
        guard let query = self.textField.text else { return }
        
        self.searcher.filterCountries(self.countries, withQuery: query) { countries in
            self.filtered = countries
            self.tableView.reloadData()
        }
        
    }
    
}

extension SimpleViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.filtered[indexPath.row]
        self.textField.text = item
    }
    
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

extension SimpleViewController {
    
    func setupViews() {
        self.textField.becomeFirstResponder()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}
