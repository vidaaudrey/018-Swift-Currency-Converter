//
//  Country.swift
//  CountryIDPhotosTableView2
//
//  Created by Audrey Li on 4/23/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

public struct AppConfig {
    static let showFlagCodeMode = ShowFlagCodeMode.Hybrid
    
    public static let availableCurrencyExchangeRatelist:[Currency] = [Currency.AUD, Currency.BGN, Currency.BRL, Currency.CAD, Currency.CHF, Currency.CNY, Currency.CZK, Currency.DKK, Currency.EUR, Currency.GBP, Currency.HKD, Currency.HRK, Currency.HUF, Currency.IDR, Currency.ILS, Currency.INR, Currency.JPY, Currency.KRW, Currency.MXN, Currency.MYR, Currency.NOK, Currency.NZD, Currency.PHP, Currency.PLN, Currency.RON, Currency.RUB, Currency.SEK, Currency.SGD, Currency.THB, Currency.TRY, Currency.USD, Currency.ZAR]

}


public enum ShowFlagCodeMode{
    case AllCode
    case Hybrid
    case AllPNG
}

public class Country{
    let name:String!
    let code: String!
    let flagCode: String!
    let isFlagCodeAvailable: Bool
    let currencyName: String!
    var currency: Currency!
    public init(name: String, code: String,currency: Currency = .USD, currencyName: String, isFlagCodeAvailable: Bool){
        self.name = name
        self.code = code
        self.currency = currency
        self.currencyName = currencyName
        self.flagCode = "\(FlagCode(char: Array(code)[0]).rawValue)\(FlagCode(char: Array(code)[1]).rawValue)"
        self.isFlagCodeAvailable = isFlagCodeAvailable
    }
}


public class Countries{
    public var countries:[String:Country] = [:]
    

    
    public func getCountriesWithAvailableExchangeRate() -> [Country] {
        let filteredData = countries.filter() {return AppConfig.availableCurrencyExchangeRatelist.containsElement($1.currency)}

        let valueArray:[Country] = filteredData.toArray() {return $1}
        return sorted(valueArray) { $0.name < $1.name }
        
    }
    
    public func getUserInterestedCountries(countryCodes:[String]) -> [Country] {
        let filteredData = countries.filter(){
            return countryCodes.containsElement($1.code)
        }
        let valueArray: [Country] = filteredData.toArray(){return $1}
//        return sorted(valueArray){ $0.name < $1.name}
        return valueArray
    }
    
    public init(){
        
        let noFlagListCountryCodes = ["IM", "NQ","JT","UM","SU","YD","DD","CT","PM","BQ","MI","ZZ","PC","SJ","VD","HM","PZ","BV","CS","PU","IO","FQ","NT","WK","FX"]
        let nonEmojiCountryCodes = ["IM", "NQ", "MF", "MH", "JT", "UM", "SU", "MU", "GG", "AX", "YD", "DD", "CT", "PM", "NF", "BQ", "TD", "MI", "GL", "CC", "TK", "NR","ZZ", "PC", "SJ", "YT", "BL", "TW", "PF", "VD", "VA", "JE", "CX", "HM", "EH", "PZ", "BV", "PN", "CS", "PU", "IO", "FQ", "AN", "AQ", "NT", "MC", "FK", "WK", "WF", "SH", "FX", "GS", "FM"]

        var countryNames: [String]!
        var countryCodes: [String]!
        var currencyCodes: [String]!
        var currencyNames: [String]!
        
        
        var error: NSErrorPointer = nil
        let csvURL = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("countriesg", ofType: "tsv")!)
        let tab = NSCharacterSet(charactersInString: "\t")
        if let csvData = CSV(contentsOfURL: csvURL!, delimiter: tab, encoding: NSUTF8StringEncoding, error: error){
            if error != nil {
                println("error converting the file")
            } else {
                let columns = csvData.columns
                countryNames = csvData.columns["name"]
                countryCodes = csvData.columns["ISO3166-1-Alpha-2"]
                currencyCodes = csvData.columns["currency_alphabetic_code"]
                currencyNames = csvData.columns["currency_name"]
            }
        }
        
        
        if countryNames != nil && countryCodes != nil && countryCodes != nil {
            for var i = 0 ; i < countryNames.count; i++ {
                let isFlagCodeAvailable = noFlagListCountryCodes.contains(countryCodes[i]) ? false : true
               let currency = Currency(currencyCode: currencyCodes[i])
                countries[countryCodes![i]] = Country(name: countryNames![i],code: countryCodes![i], currency: currency, currencyName: currencyNames[i], isFlagCodeAvailable: isFlagCodeAvailable)
            }
        }
       
        
      //  println(countriesDict.count)
//        println("no flag countries\(noFlagListCountryCodes.count)")
//        println(countries.count)
//        println(nonEmojiCountryCodes.count)
        // No flag list countries
//        NQ  Dronning Maud Land
//        JT  Johnston Island
//        UM  U.S. Minor Outlying Islands
//        SU  Union of Soviet Socialist Republics
//        YD  People's Democratic Republic of Yemen
//        DD  East Germany
//        CT  Canton and Enderbury Islands
//        PM  Saint Pierre and Miquelon
//        BQ  British Antarctic Territory
//        MI  Midway Islands
//        ZZ  Unknown or Invalid Region
//        PC  Pacific Islands Trust Territory
//        SJ  Svalbard and Jan Mayen
//        VD  North Vietnam
//        HM  Heard Island and McDonald Islands
//        PZ  Panama Canal Zone
//        BV  Bouvet Island
//        CS  Serbia and Montenegro
//        PU  U.S. Miscellaneous Pacific Islands
//        IO  British Indian Ocean Territory
//        FQ  French Southern and Antarctic Territories
//        NT  Neutral Zone
//        WK  Wake Island
//        FX  Metropolitan France
    }
    
}