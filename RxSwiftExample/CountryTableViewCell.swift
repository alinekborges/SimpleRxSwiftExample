//
//  CountryTableViewCell.swift
//  RxSwiftExample
//
//  Created by Aline Borges on 01/02/18.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    func bind(text: String) {
        titleLabel.text = text
    }
    
}
