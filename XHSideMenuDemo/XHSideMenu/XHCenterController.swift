//
//  XHCenterController.swift
//  XHSideMenu
//
//  Created by Sunny on 15/4/4.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

class XHCenterController: UIViewController,UINavigationControllerDelegate{
    
    private var selectedVC:UIViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        selectViewController(0) //Default
    }
    
    private func setUpUI() {
        //XHNavBar
        let navigationBar = navigationController?.navigationBar
        navigationBar?.titleTextAttributes = [NSForegroundColorAttributeName:XHNavTintColor]
        navigationBar?.barTintColor = XHNavBarColor
        navigationBar?.tintColor = XHNavTintColor
        
        //XHMenuButton
        let menuButton = XHMenuButton()
        menuButton.menuColor = XHNavTintColor
        menuButton.tapHandler = {
            if let containerVC = self.navigationController?.parentViewController as? XHContainerController {
                containerVC.tapSideMenu()
            }
        }
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
        
        //BackButton
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: UIBarMetrics.Default)
        
        //center handle gesture
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("tapHandler")))
        
        //delegate
        navigationController?.delegate = self
        
        //add childVC
        XHChildVCHelper.create(self)
    }
    
    /**
    choose a controller
    
    :param: index which controller
    */
    func selectViewController(index:Int) {
        let newVC = childViewControllers[index] as UIViewController
        if newVC == selectedVC {
            return
        }
        selectedVC?.view.removeFromSuperview()
        view.addSubview(newVC.view)
        newVC.view.frame = view.bounds
        selectedVC = newVC
        title = selectedVC!.title
    }
    
    func tapHandler() {
        if let containerVC = self.navigationController?.parentViewController as? XHContainerController {
            if containerVC.isOpening {
                containerVC.tapSideMenu()
            }
        }
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        if let containerVC = self.navigationController?.parentViewController as? XHContainerController {
            if viewController.isKindOfClass(XHCenterController) {
                containerVC.allowDrag = true
            } else {
                containerVC.allowDrag = false
            }
        }
    }
}


