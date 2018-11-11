//
//  CountrySearcher.swift
//  RxSwiftExample
//
//  Created by Aline Borges on 11/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation

protocol CountrySearchable {
    func filterCountries(_ countries: [String], withQuery query: String) -> [String]
}

class CountrySearcher: CountrySearchable {
    func filterCountries(_ countries: [String], withQuery query: String) -> [String] {
        return countries.filter {
            $0.lowercased().contains(query.lowercased())
        }
    }
}
