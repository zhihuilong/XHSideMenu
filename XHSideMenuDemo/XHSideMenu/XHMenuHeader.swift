//
//  XHMenuHeader.swift
//  XHSideMenu
//
//  Created by Sunny on 15/4/14.
//  Copyright (c) 2015年 Keemo. All rights reserved.
//

import UIKit

let menuAvatarWidth: CGFloat = 60

class XHMenuHeader: UIView {
    var tapHandler: (()->())?
    private let imageView = UIImageView()
    private let nickLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        bounds = CGRect(origin: CGPointZero, size: CGSize(width: XHViewWidth, height: XHHeaderHeight))
        backgroundColor = XHNavBarColor
        addSubview(imageView)
        addSubview(nickLabel)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: "didTap"))
        
        let imageOrigin = CGPoint(x: 20 ,y: 45)
        imageView.frame = CGRect(origin: imageOrigin, size: CGSize(width: menuAvatarWidth,height: menuAvatarWidth))
        imageView.layer.cornerRadius = menuAvatarWidth / 2
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = UIColor.yellowColor()
        
        let nickOrigin = CGPoint(x: imageOrigin.x+menuAvatarWidth+XHMargin,y: imageOrigin.y)
        nickLabel.frame = CGRect(origin: nickOrigin, size: CGSize(width: XHViewWidth - nickOrigin.x,height: menuAvatarWidth))
        nickLabel.text = "Sunny"
        nickLabel.textColor = XHNavTintColor
    }
    
    func didTap() {
        if let tap = tapHandler {
            tap()
        } else {
            print("you need assign the tapHandler！！！")
        }
    }
}
