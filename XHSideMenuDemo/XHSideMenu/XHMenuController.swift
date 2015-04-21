//
//  XHMenuController.swift
//  XHSideMenu
//
//  Created by Sunny on 15/4/4.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

enum SideMenuStyle : Int {
    case under    //menu under the center
    case cover    //menu under the center
    case parallel //no effect
    case parallax //visual effect
}

class XHMenuController: UITableViewController {
    
    var centerViewController:XHCenterController!
    var style:SideMenuStyle = SideMenuStyle.under  //default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView.tableHeaderView = XHMenuHeader()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return XHChildCount
    }
    
    override func tableView(tableView:UITableView, cellForRowAtIndexPath indexPath:NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MenuCell"
        var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
        }
        cell?.textLabel?.textColor = UIColor.lightGrayColor()
        cell!.textLabel?.text = XHMenuTitles[indexPath.row]
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        centerViewController.selectViewController(indexPath.row)
        if let containerVC = self.parentViewController as? XHContainerController {
            containerVC.tapSideMenu()
        }
    }
}
