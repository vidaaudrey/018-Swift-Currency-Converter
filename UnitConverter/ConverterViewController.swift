//
//  ConverterViewController.swift
//  UnitConverter
//
//  Created by Audrey Li on 4/27/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController{
    
    @IBOutlet weak var sourceCurrencyLabel: UILabel!
    @IBOutlet weak var targetCurrencyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sourceCurrencyTextfield: UITextField!
    @IBOutlet weak var targetCurrencyTextField: UITextField!
    @IBOutlet weak var sourceFlagBtn: UIButton!
    @IBOutlet weak var targetFlagBtn: UIButton!
    @IBOutlet weak var switchBtn: UIButton!
    @IBOutlet weak var lastUpdatedTimeLabel: UILabel!
    
    var isSourceBtnFlagPressed = true // set a flag so both the button can share the same target view controller and segue
    
    var tableViewDataSource: TableViewDataSource!
    var userInterestedCountryList:[String] = ["US", "CN","DE", "AU", "FR", "BR", "JP"] {
        didSet {
            if userInterestedCountryList.count != 0 {
                let countries = self.countries.getUserInterestedCountries(userInterestedCountryList)
                cellData = getCellDataWithCountries(countries)
            }
        }
    }
    var countries: Countries!
    var converter: CurrencyConverter!
    
    var cellData:[CellData] = []{
        didSet{
            if cellData.count != 0 {
                updateUI()
                updateCellData()
            }
        }
    }
    var sourceCurrencyCountry: Country!{
        didSet {
            if cellData.count != 0 {
                updateUI()
                updateCellData()
            }
        }
    }
    var targetCurrencyCountry: Country! {
        didSet {
         updateUI()
        }
    }
    var sourceCurrencyAmount: Double = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchBtn.setImage(StyleKit.imageOfFreshButton1, forState: .Normal)
        
        let exchangeRateUpdatedHandler = {(date: String, isRateUpdatedSinceLastCheck: Bool) -> Void in
            self.lastUpdatedTimeLabel.text = "Last updated on \(date)"
            if isRateUpdatedSinceLastCheck {
                if (self.cellData.count != 0) && (self.countries != nil) {
                    self.cellData = self.getCellDataWithCountries(self.countries.getUserInterestedCountries(self.userInterestedCountryList))
                }
            }
        }
        converter = CurrencyConverter(updateTimeInterval:2, exchangeRateUpdatedHandler: exchangeRateUpdatedHandler)
        
        countries = Countries()
        sourceCurrencyCountry = countries.countries["US"]
        targetCurrencyCountry = countries.countries["CN"]
        
       let userInterestedCountries = countries.getUserInterestedCountries(userInterestedCountryList)
        cellData = getCellDataWithCountries(userInterestedCountries)
        
        var deleteHandler =  {(item: AnyObject) -> Void in
          self.deleteUserCountryListItem(item)
        }

        
        tableViewDataSource = TableViewDataSource(items: cellData, cellIdentifier: "cell", didSelectHandler: nil, deleteHandler: deleteHandler, configureBlock: { (cell, item) -> () in
            if let actualCell:CurrencyTableViewCell = cell as? CurrencyTableViewCell {
                actualCell.configureForItem(item)
            }
        })
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDataSource
        
        updateUI()
        
    }
    private func deleteUserCountryListItem(item: AnyObject){
        if let country = item as? CellData {
            userInterestedCountryList.remove(country.targetCountry.code)
        }
    }
    
    private func getCellDataWithCountries(countries:[Country]) -> [CellData]{
        var tempCellData:[CellData] = []
        for country in countries {
            let exchangeRate = converter.getExchangeRate(sourceCurrencyCountry.currency, targetCurrency: country.currency)
            let data = CellData(sourceCountry: sourceCurrencyCountry, targetCountry: country, sourceCurrencyAmont: sourceCurrencyAmount, exchangeRate: exchangeRate)
            tempCellData.append(data)
        }
        return tempCellData
        
    }
    func updateUI(){
        sourceCurrencyLabel.text = sourceCurrencyCountry.currency.description
        targetCurrencyLabel.text = targetCurrencyCountry.currency.description

        sourceCurrencyTextfield.text = "\(sourceCurrencyAmount)"
        let targetAmount = converter.getTargetCurrencyAmount(sourceCurrencyAmount, sourceCurrency: sourceCurrencyCountry.currency, targetCurrency: targetCurrencyCountry.currency)
        targetCurrencyTextField.text = "\(targetAmount!)"
       
       
        if let image = UIImage(named: sourceCurrencyCountry.code) {
            sourceFlagBtn.backgroundColor = UIColor(patternImage: image)
            sourceFlagBtn.setTitle("", forState: .Normal)
        } else {
             sourceFlagBtn.setTitle(sourceCurrencyCountry.flagCode, forState: .Normal)
        }
        if let image = UIImage(named: targetCurrencyCountry.code) {
            targetFlagBtn.backgroundColor = UIColor(patternImage: image)
            targetFlagBtn.setTitle("", forState: .Normal)
        } else {
            targetFlagBtn.setTitle(targetCurrencyCountry.flagCode, forState: .Normal)
        }
    }
    func updateCellData(){
        for data in cellData{
            data.sourceCurrencyAmont = sourceCurrencyAmount
            data.exchangeRate = converter.getExchangeRate(sourceCurrencyCountry.currency, targetCurrency: data.targetCountry.currency)
        }
        if tableViewDataSource != nil {
            tableViewDataSource.items = cellData
            tableView.reloadData()
        }
    }
    
    @IBAction func sourceFlagBtnPressed(sender: UIButton) {
        isSourceBtnFlagPressed = true
        performSegueWithIdentifier("chooserSegue", sender: self)
    }
    @IBAction func targetFlagBtnPressed(sender: UIButton) {
        isSourceBtnFlagPressed = false
        performSegueWithIdentifier("chooserSegue", sender: self)
    }
    
    @IBAction func switchBtnPressed(sender: UIButton) {
        let tempCountry = sourceCurrencyCountry
        sourceCurrencyCountry = targetCurrencyCountry
        targetCurrencyCountry = tempCountry
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? CurrencyChooserTableViewController {
            dvc.data = getCellDataWithCountries(countries.getCountriesWithAvailableExchangeRate())
            dvc.isSourceBtnFlagPressed = isSourceBtnFlagPressed
            dvc.doneHandler = {(country: Country, isSourceCountry: Bool) -> Void in
                self.didPickCurrency(country, isSourceCountry: isSourceCountry)
            }
        }
    }
    private func didPickCurrency(country: Country, isSourceCountry: Bool){
        userInterestedCountryList.append(country.code) // add to the interested list
        if isSourceCountry {
            sourceCurrencyCountry = country
        } else {
            targetCurrencyCountry = country
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    @IBAction func currencyInputChanged(sender: UITextField) {
        println(sender.text)
        if sender.text != "" {
            if let amountNumber = sender.text.toDouble() {
                if sender == sourceCurrencyTextfield {
                    sourceCurrencyAmount = amountNumber
                    let targetAmount = converter.getTargetCurrencyAmount(sourceCurrencyAmount, sourceCurrency: sourceCurrencyCountry.currency, targetCurrency: targetCurrencyCountry.currency)
                    targetCurrencyTextField.text = "\(targetAmount!)"
                } else {
                    let exchangeRate = converter.getExchangeRate(targetCurrencyCountry.currency, targetCurrency: sourceCurrencyCountry.currency)
                    if let eRate = exchangeRate {
                        sourceCurrencyAmount = eRate * amountNumber
                        sourceCurrencyTextfield.text = "\(sourceCurrencyAmount)"
                    }
                    
                }
            }
        }

    }

    @IBAction func currencyInputEnded(sender: UITextField) {
        updateCellData()
        
    }

    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
