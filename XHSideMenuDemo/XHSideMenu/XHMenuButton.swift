//
//  XHMenuButton.swift
//  XHSideMenu
//
//  Created by Sunny on 15/4/4.
//  Copyright (c) 2015年 Sunny. All rights reserved.
//

import UIKit

let kMenuButtonWidth:CGFloat = 20

class XHMenuButton: UIView {
    var tapHandler:(()->())?
    var menuColor:UIColor? {
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func didMoveToSuperview() {
        backgroundColor = UIColor.clearColor()
        bounds = CGRect(x: 0, y: 0, width: kMenuButtonWidth, height: kMenuButtonWidth)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTap"))
    }
    
    func didTap() {
        if let tap = tapHandler {
            tap()
        } else {
            println("you need assign the tapHandler！！！")
        }
    }
    
    override func drawRect(rect: CGRect) {
        var drawColor = UIColor.whiteColor() //default
        if let color = menuColor {
            drawColor = color
        }
        
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: 2))
        path.addLineToPoint(CGPoint(x: kMenuButtonWidth, y: 2))
        path.lineWidth = 1.5
        drawColor.set()
        path.stroke()
        
        let path1 = UIBezierPath()
        path1.moveToPoint(CGPoint(x: 4, y: 10 ))
        path1.addLineToPoint(CGPoint(x: kMenuButtonWidth-4.0, y: 10 ))
        path1.lineWidth = 1.5
        drawColor.set()
        path1.stroke()
        
        let path2 = UIBezierPath()
        path2.moveToPoint(CGPoint(x: 0, y: 18))
        path2.addLineToPoint(CGPoint(x: kMenuButtonWidth, y: 18))
        path2.lineWidth = 1.5
        drawColor.set()
        path2.stroke()
    }
}
