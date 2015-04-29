//
//  CurrencyTableViewCell.swift
//  UnitConverter
//
//  Created by Audrey Li on 4/27/15.
//  Copyright (c) 2015 shomigo.com. All rights reserved.
//

import UIKit

class CurrencyTableViewCell: UITableViewCell {

    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currenyAmontLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureForItem(item:AnyObject?){
        if let cellData:CellData = item as? CellData {
            
            if let image = UIImage(named: cellData.targetCountry.code){
                flagImageView.image = image
            } 
            currencyCodeLabel.text = cellData.targetCountry.currency.description
            currencyNameLabel.text = "\(cellData.targetCountry.name) (\(cellData.targetCountry.currencyName))"
            currenyAmontLabel.text = SimpleCurrencyConverter.getTargetCurrencyFormattedString(cellData.sourceCurrencyAmont, sourceCurrency: cellData.sourceCountry.currency, targetCurrency: cellData.targetCountry.currency, exchangeRate: cellData.exchangeRate)
            
        }
    }

}
