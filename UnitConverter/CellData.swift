//
//  CellData.swift
//  UnitConverter
//
//  Created by Audrey Li on 4/27/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

class CellData {
    var sourceCountry: Country
    var targetCountry: Country
    var sourceCurrencyAmont: Double
    var exchangeRate: Double!
    init(sourceCountry: Country, targetCountry: Country, sourceCurrencyAmont: Double, exchangeRate: Double?){
        self.sourceCountry = sourceCountry
        self.targetCountry = targetCountry
        self.sourceCurrencyAmont = sourceCurrencyAmont
        self.exchangeRate = exchangeRate
    }
}