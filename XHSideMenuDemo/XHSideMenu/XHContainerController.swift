//
//  XHContainerController.swift
//  XHSideMenu
//
//  Created by Sunny on 15/4/4.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

class XHContainerController: UIViewController,UIGestureRecognizerDelegate {
    
    private let menuViewController: UIViewController!
    private var centerViewController: UIViewController!
    private let animationTime: NSTimeInterval = 0.3
    private(set) var isOpening                = false
    var allowDrag                             = true
    
    init(sideMenu: UIViewController, center: UIViewController) {
        menuViewController = sideMenu
        centerViewController = center
        super.init(nibName: nil, bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target:self, action:Selector("handleGesture:"))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
        setupMenu()
    }
    
    private func setupMenu() {
        let menu = menuViewController as XHMenuController
        switch menu.style {
        case .under:
            addChildViewController(menuViewController)
            view.addSubview(menuViewController.view)
            menuViewController.didMoveToParentViewController(self)
            
            addChildViewController(centerViewController)
            view.addSubview(centerViewController.view)
            centerViewController.didMoveToParentViewController(self)
            
            menuViewController.view.frame = CGRect(x: 0, y: 0, width: XHMenuWidth, height: view.frame.height)
            updateShadow(true) //show shadow
            
        case .parallel:fallthrough
        case .parallax:fallthrough
        case .cover:
            addChildViewController(centerViewController)
            view.addSubview(centerViewController.view)
            centerViewController.didMoveToParentViewController(self)
            
            addChildViewController(menuViewController)
            view.addSubview(menuViewController.view)
            menuViewController.didMoveToParentViewController(self)
            
            menuViewController.view.frame = CGRect(x: -XHMenuWidth, y: 0, width: XHMenuWidth, height: view.frame.height)
        default: break
        }
    }
    
    func handleGesture(recognizer:UIPanGestureRecognizer) {
        //获取在window上的点击位置
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        
        //计算进度:(isOpening ? 1.0 : -1.0)保证为正数
        var progress = translation.x / XHMenuWidth * (isOpening ? 1.0 : -1.0)
       
        //保证在0~1之间
        progress = min(max(progress,0.0), 1.0)
        
        switch recognizer.state {
        case .Began:
            let isOpen = floor(centerViewController.view.frame.origin.x / XHMenuWidth)
            //根据frame设置侧栏开启状态
            isOpening = isOpen == 1.0 ? false :true
            case .Changed:
            //正在开启,则progress递增至1，否则递减为0
            setToPercent(isOpening ? progress : (1 - progress))
        case .Ended: fallthrough
        case .Cancelled: fallthrough
        case .Failed:
            var targetProgress:CGFloat
            if isOpening {
                //正在开启,小于一半则回弹为0
                targetProgress = progress < 0.5 ? 0.0 :1.0
            } else {
                //正在关闭,小于一半则回弹为1
                targetProgress = progress < 0.5 ? 1.0 :0.0
            }
            UIView.animateWithDuration(animationTime, animations: {
                self.setToPercent(targetProgress)
            })
        default: break
        }
    }
    
    private func setToPercent(percent: CGFloat) {
        
        let menu = menuViewController as XHMenuController
        switch menu.style {
        case .parallel:
            //设置centerVC的offsetX为正百分比
            centerViewController.view.frame.origin.x = XHMenuWidth * percent
            //设置menuVC的offsetX为负百分比
            menuViewController.view.frame.origin.x = XHMenuWidth * (percent - 1.0)
            
        case .cover:
            println("percent--\(percent)")
            //设置menuVC的offsetX为负百分比
            menuViewController.view.frame.origin.x = XHMenuWidth * (percent - 1.0)
        case .under:
            //设置centerVC的offsetX为正百分比
            centerViewController.view.frame.origin.x = XHMenuWidth * percent

        //case .parallax:
        default: break
        }
    }
    
    func tapSideMenu() {
        let isOpen = floor(centerViewController.view.frame.origin.x/XHMenuWidth)
        isOpening = isOpen == 1.0 ? false :true
        let targetProgress: CGFloat = isOpen == 1.0 ? 0.0: 1.0
        
        UIView.animateWithDuration(animationTime, animations: {
            self.setToPercent(targetProgress)
            }, completion: { _ in
                self.menuViewController.view.layer.shouldRasterize = false
        })
    }
    
    private func updateShadow(showShadow:Bool) {
        let centerView = centerViewController.view
        if showShadow {
            centerView.layer.masksToBounds = false
            centerView.layer.shadowRadius = 10
            centerView.layer.shadowOpacity = 0.8
            
            if centerView.layer.shadowPath == nil {
                centerView.layer.shadowPath = UIBezierPath(rect: centerView.bounds).CGPath
            }
            else{
                let currentPath = CGPathGetPathBoundingBox(centerView.layer.shadowPath)
                if (CGRectEqualToRect(currentPath, centerView.bounds) == false){
                    centerView.layer.shadowPath = UIBezierPath(rect: centerView.bounds).CGPath
                }
            }
        }
        else if (centerView.layer.shadowPath != nil) {
            centerView.layer.shadowRadius = 0
            centerView.layer.shadowOpacity = 0
            centerView.layer.shadowPath = nil
            centerView.layer.masksToBounds = true
        }
    }
    
    //delegate搞定二级页面不允许拖拽
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return allowDrag
    }
}
