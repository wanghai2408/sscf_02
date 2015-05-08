
//
//  AlertView.swift
//  盛世财富
//
//  Created by 肖典 on 15/5/8.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import Foundation

class AlertView {
    class func showMsg(msg:String,parentView:UIView){
        var hintLabel = UILabel(frame: CGRectMake(parentView.frame.size.width/2-80, parentView.frame.size.height-100, 160, 30))
        hintLabel.textAlignment = NSTextAlignment.Center
        
        hintLabel.backgroundColor = UIColor.blackColor()
        hintLabel.layer.masksToBounds = true
        hintLabel.layer.cornerRadius = 10.0
        hintLabel.alpha = 0
        hintLabel.text = msg
        hintLabel.textColor = UIColor.whiteColor()
        
        parentView.addSubview(hintLabel)
        
        UIView.animateWithDuration(3.0, delay: 0.0, options: nil, animations: {
            hintLabel.alpha = 1.0
            }, completion: {(finished:Bool) -> Void in
                hintLabel.removeFromSuperview()
        })
    }
}