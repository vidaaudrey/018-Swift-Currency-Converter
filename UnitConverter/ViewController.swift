//
//  ViewController.swift
//  UnitConverter
//
//  Created by Audrey Li on 4/26/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var textLabel: UILabel!
    
    var converter: CurrencyConverter!
    var pickerData = [Currency.USD, Currency.CNY, Currency.AUD]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        converter = CurrencyConverter(exchangeRateUpdatedHandler: nil)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        let baseCurrency = Currency.USD
        HttpService.getJSON("\(FrameworkConstants.currencyAPIBaseURLPrefix)\(baseCurrency.description)", callback: { (jsonData) -> Void in
            self.converter.updateRatesWithJSONData(baseCurrency: baseCurrency, jsonData: jsonData)
            println(self.converter.getTargetCurrencyFormattedString(100, sourceCurrency: Currency.EUR, targetCurrency: Currency.CNY))
        })
        
        let countries = Countries()

        
        let filteredCountries = countries.getCountriesWithAvailableExchangeRate()
        for country in filteredCountries {
            println("\(country.currencyName) \(country.currency.symbol()) \(country.flagCode)")
        }
    }
    
    
    // picker rated methods
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
//    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
//        return pickerData[row].description
//    }
//    func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        let titleData = pickerData[row].description
//        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.blueColor()])
//        return myTitle
//    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        var pickerLabel = view as! UILabel!
        if view == nil { 
            pickerLabel = UILabel()
            //color the label's background
            let hue = CGFloat(row)/CGFloat(pickerData.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
        }
        let flagCode = "\u{1F1FA}\u{1F1F8}"
        let titleData = pickerData[row].description + flagCode
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel!.attributedText = myTitle
        return pickerLabel
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textLabel.text = pickerData[row].symbol() + pickerData[row].description
    }

}

