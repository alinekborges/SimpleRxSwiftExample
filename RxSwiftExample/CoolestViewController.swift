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

class CoolestViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let countries = Observable.just(["Argentina", "Bolívia", "Brasil", "Chile", "Colômbia", "Equador", "Guiana", "Paraguai", "Peru", "Suriname", "Uruguai", "Venezuela"])
    var filtered: Observable<[String]>!
    var searchText: Observable<String>!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textField.becomeFirstResponder()
        
        setupBindings()
    }
}

extension CoolestViewController {
    
    func setupBindings() {
        
        searchText = textField.rx.text.orEmpty
            .asObservable()
            .map { $0.lowercased() }
        
        filtered = Observable.combineLatest(searchText, countries) {
            text, countries in
            return countries.filter {$0.lowercased().contains(text)}
        }
        
        filtered.bind(to: tableView
            .rx
            .items(cellIdentifier: "countryCell", cellType: CountryTableViewCell.self)) {
                row, element, cell in
                cell.bind(text: element)
        }.disposed(by: disposeBag)
        
    }
    
}



