//
//  CurrencyChooserTableViewController.swift
//  UnitConverter
//
//  Created by Audrey Li on 4/27/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class CurrencyChooserTableViewController: UITableViewController {
    var data: [CellData]!
    var isSourceBtnFlagPressed = true
    var selectedCountry:Country!
    var doneHandler: ((country: Country, isSourceCountry: Bool) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chooserCell", forIndexPath: indexPath) as! UITableViewCell
        let tempData = data[indexPath.row].targetCountry
        cell.textLabel?.text = tempData.name +  "- " +  tempData.currency.description + " " + tempData.currency.symbol()
        cell.detailTextLabel?.text = tempData.currencyName
        if let image = UIImage(named: tempData.code){
            cell.imageView?.image = image
        }
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedCountry = data[indexPath.row].targetCountry
        doneHandler?(country: selectedCountry, isSourceCountry: isSourceBtnFlagPressed)
    }

}
