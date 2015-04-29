//
//  TableViewDataSource.swift
//  012-Word-Color-Lean-View-Controller-With-UITableView-UICollectionView
//
//  Created by Audrey Li on 4/5/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import Foundation
import UIKit

public typealias TableViewCellConfigureBlock = (cell: UITableViewCell, item: AnyObject?) -> ()

public class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    var items: NSArray = []
    var itemIdentifier: String?
    var configureCellBlock: TableViewCellConfigureBlock?
    var didSelectHandler: ((item: AnyObject) -> Void)!
    var deleteHandler: ((item: AnyObject) -> Void)!
    
    public init(items: NSArray, cellIdentifier: String, didSelectHandler: ((item: AnyObject) -> Void)!, deleteHandler: ((item: AnyObject) -> Void)!, configureBlock: TableViewCellConfigureBlock){
        self.items = items
        self.itemIdentifier = cellIdentifier
        self.configureCellBlock = configureBlock
        self.didSelectHandler = didSelectHandler
        self.deleteHandler = deleteHandler
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(self.itemIdentifier!, forIndexPath: indexPath) as! UITableViewCell
        let item: AnyObject = itemAtIndexPath(indexPath)
        
        if (self.configureCellBlock != nil) {
            self.configureCellBlock!(cell: cell, item: item)
        }
        
        return cell
    }
   public func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.items[indexPath.row]
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        didSelectHandler?(item: items[indexPath.row])
    }
   
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    public func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            deleteHandler?(item: items[indexPath.row])
        }
    }
    
}