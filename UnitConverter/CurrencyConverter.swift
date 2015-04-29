//
//  CurrencyConverter.swift
//  UnitConverter
//
//  Created by Audrey Li on 4/26/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import Foundation

public class SimpleCurrencyConverter {
    public class func getTargetCurrencyFormattedString(sourceAmont: Double, sourceCurrency: CurrencySymbol, targetCurrency: CurrencySymbol, exchangeRate: Double) -> String {
        let targetAmount = sourceAmont / exchangeRate
        return formattedString(sourceAmont * exchangeRate, currency: targetCurrency)
    }

    public class func formattedString(amount: Double, currency: CurrencySymbol) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencySymbol = currency.symbol()
        return formatter.stringFromNumber(amount)!
    }
}

public class CurrencyConverter: NSObject, Formattable{
    public var baseCurrency: CurrencySymbol!
    public var date: String!
    public var rates:[String: Double] = [:]
    public var isRateUpdatedSinceLastCheck:Bool = false
    public var exchangeRateUpdatedHandler: ((date: String, isRateUpdatedSinceLastCheck: Bool) -> Void)!
    public var offlineJSONDict = [ "base": "USD", "date": "2015-04-29",
        "rates": [
            "AUD": 1.2827,
            "BGN": 1.8069,
            "BRL": 2.9733,
            "CAD": 1.2119,
            "CHF": 0.9551,
            "CNY": 6.1948,
            "CZK": 25.364,
            "DKK": 6.8927,
            "GBP": 0.6614,
            "HKD": 7.75,
            "HRK": 7.0284,
            "HUF": 278.53,
            "IDR": 12954,
            "ILS": 3.9244,
            "INR": 63.563,
            "JPY": 119.51,
            "KRW": 1078.25,
            "MXN": 15.358,
            "MYR": 3.5741,
            "NOK": 7.8298,
            "NZD": 1.3216,
            "PHP": 44.281,
            "PLN": 3.7076,
            "RON": 4.08,
            "RUB": 51.215,
            "SEK": 8.6674,
            "SGD": 1.3375,
            "THB": 32.55,
            "TRY": 2.7314,
            "ZAR": 12.182,
            "EUR": 0.9239
        ]
    ]
    
    public init(baseCurrency: CurrencySymbol = Currency.USD, updateTimeInterval: NSTimeInterval = 0, exchangeRateUpdatedHandler: ((date: String,isRateUpdatedSinceLastCheck: Bool) -> Void)!){
        super.init()
        self.exchangeRateUpdatedHandler = exchangeRateUpdatedHandler
        updateRatesWithJSONData(baseCurrency: baseCurrency, jsonData: offlineJSONDict)
        
        // if the timeInterval equals 0, then don't update
        if updateTimeInterval != 0 {
            updateCurrencyWithTimeInterval(updateTimeInterval)
        }
    }
    // call this method separately with updated json data to get updated rates
    public func updateRatesWithJSONData(baseCurrency: CurrencySymbol = Currency.USD, jsonData: AnyObject){
        self.baseCurrency = baseCurrency
        if let jsonDict = jsonData as? NSDictionary {
            populateRatesArrayWithJSONDict(jsonDict)
        }
    }
    
    private func populateRatesArrayWithJSONDict(jsonDict: NSDictionary){
       
        if let jsonRateDict = jsonDict["rates"] as? NSDictionary {
            self.date = jsonDict["date"] as! String // only update the date if we did get the data
            var newRates:[String:Double] = [:]
            newRates["\(baseCurrency.description)"] = 1 // add base rate in case the target or source currency is the base currency
            for (K,V) in jsonRateDict {
                newRates["\(K)"] = "\(V)".toDouble()
            }
            
            if newRates.count != 0 {
                self.offlineJSONDict = jsonRateDict
            }
            
            // only update "isRateUpdatedSinceLastCheck" if it did change, because the updates will cause the  UIView reload
            if rates.count != 0 && newRates.count != 0 {
                println("if equal \(newRates == rates)")
                if newRates != rates {
                    rates = newRates
                    isRateUpdatedSinceLastCheck = true
                } else if isRateUpdatedSinceLastCheck {
                    isRateUpdatedSinceLastCheck = false  // the other case is the status was updated last time but now it is not, so we need to change it back to false
                }
            } else if rates.count == 0 && newRates.count != 0 {
                rates = newRates
            }
            
            exchangeRateUpdatedHandler?(date: date, isRateUpdatedSinceLastCheck: isRateUpdatedSinceLastCheck)
        }
        
    }
    
    public func updateCurrencyWithTimeInterval(timeInterval: NSTimeInterval) {
        let timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "updateJSONRateFromURL", userInfo: nil, repeats: true)
    }

    public func updateJSONRateFromURL(){
        HttpService.getJSON("\(FrameworkConstants.currencyAPIBaseURLPrefix)\(baseCurrency.description)", callback: { (jsonData) -> Void in
            self.updateRatesWithJSONData(baseCurrency: self.baseCurrency, jsonData: jsonData)
            
        })
    }
    
    public func formattedString(amount: Double, currency: CurrencySymbol) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        formatter.currencySymbol = currency.symbol()
        return formatter.stringFromNumber(amount)!
    }

    public func getTargetCurrencyAmount(sourceAmount:Double, sourceCurrency: CurrencySymbol, targetCurrency: CurrencySymbol) -> Double? {
        let exchangeRate = getExchangeRate(sourceCurrency, targetCurrency: targetCurrency)
        if let eRate = exchangeRate {
            return sourceAmount * eRate
        } else {
            return nil
        }
    }
   public func getExchangeRate(sourceCurrency: CurrencySymbol, targetCurrency: CurrencySymbol) -> Double? {
        let sourceToBaseRate = self.rates["\(sourceCurrency.description)"]
        let targetToBaseRate = self.rates["\(targetCurrency.description)"]
        if sourceToBaseRate != nil && targetToBaseRate != nil {
           return targetToBaseRate! / sourceToBaseRate!
        } else {
            return nil
        }
    }
    
  public func getTargetCurrencyFormattedString(sourceAmont: Double, sourceCurrency: CurrencySymbol, targetCurrency: CurrencySymbol) -> String {
        
        if let exchangeRate = getExchangeRate(sourceCurrency, targetCurrency: targetCurrency){
            return formattedString(sourceAmont * exchangeRate, currency: targetCurrency)
        }else {
            return "No exchange rate data"
        }
    }
}
