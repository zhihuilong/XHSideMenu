//
//  XHChildVCHelper.swift
//  XHSideMenu
//
//  Created by Sunny on 15/4/7.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

class XHChildVCHelper: NSObject {
    /**
    *  You need add your own controller in this helper method
    */
    class func create(parentVC:UIViewController) {
        let firstVC = FirstVC()
        parentVC.addChildViewController(firstVC)
        firstVC.title = XHMenuTitles[0]
        firstVC.view.backgroundColor = UIColor.yellowColor()
        
        let secondVC = SecondVC()
        parentVC.addChildViewController(secondVC)
        secondVC.title = XHMenuTitles[1]
        secondVC.view.backgroundColor = UIColor.redColor()
        
        let thirdVC = ThirdVC()
        parentVC.addChildViewController(thirdVC)
        thirdVC.title = XHMenuTitles[2]
        thirdVC.view.backgroundColor = UIColor.greenColor()
        
        let fourthVC = FourthVC()
        parentVC.addChildViewController(fourthVC)
        fourthVC.title = XHMenuTitles[3]
        fourthVC.view.backgroundColor = UIColor.orangeColor()
        
        let fifthVC = FifthVC()
        parentVC.addChildViewController(fifthVC)
        fifthVC.title = XHMenuTitles[4]
        fifthVC.view.backgroundColor = UIColor.purpleColor()
    }
}
