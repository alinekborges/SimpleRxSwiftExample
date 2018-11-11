//
//  SimpleViewController.swift
//  RxSwiftExample
//
//  Created by Aline Borges on 01/02/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CoolViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var countries: [String] = []
    var filtered: [String] = []
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.becomeFirstResponder()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setupBindings()
    }
    
}

extension CoolViewController {
    
    func setupBindings() {
        
        self.textField.rx.text.orEmpty.asObservable()
            .map { $0.lowercased() }
            .subscribe(onNext: { text in
                self.filtered = self.countries.filter {
                    $0.lowercased().contains(text)
                }
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
    }
    
}

extension CoolViewController: UITableViewDelegate, UITableViewDataSource {
    
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




