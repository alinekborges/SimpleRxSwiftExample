//
//  CountrySearcher.swift
//  RxSwiftExample
//
//  Created by Aline Borges on 11/11/2018.
//  Copyright © 2018 Aline Borges. All rights reserved.
//

import Foundation
import RxSwift

protocol CountrySearchable {
    func filterCountries(_ countries: [String],
                         withQuery query: String,
                         onCompleted: @escaping ([String])->())
    func rxFilterCountries(_ countries: [String],
                         withQuery query: String) -> Single<[String]>
}

class CountrySearcher: CountrySearchable {
    func filterCountries(_ countries: [String],
                         withQuery query: String,
                         onCompleted: @escaping ([String])->()) {
        DispatchQueue.global(qos: .background).async {
            let countries = countries.filter {
                $0.lowercased().contains(query.lowercased())
            }
            DispatchQueue.main.async {
                onCompleted(countries)
            }
        }
    }
    
    func rxFilterCountries(_ countries: [String], withQuery query: String) -> Single<[String]> {
        return Single.just(countries)
            .observeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .map { $0.filter { $0.lowercased().contains(query.lowercased())} }
            .observeOn(MainScheduler.instance)
    }
}
