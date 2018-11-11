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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            self.backgroundColor = #colorLiteral(red: 0.9391135219, green: 0.9391135219, blue: 0.9391135219, alpha: 1)
        } else {
            self.backgroundColor = .white
        }
    }
    
}
