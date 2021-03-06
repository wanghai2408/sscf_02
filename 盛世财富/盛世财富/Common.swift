//
//  Common.swift
//  盛世财富
//  公共方法
//  Created by 云笺 on 15/5/20.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import Foundation
/**
*  系统公共方法类
*/
class Common {
    
    /**
    判断用户是否登录
    
    :returns: true表示登录，false表示未登录
    */
    class func isLogin() -> Bool {
        if let token = NSUserDefaults.standardUserDefaults().objectForKey("token") as? String {
            return true
        }
        
        return false
        
    }
    //MARK:- 系统常量
    /// 转接服务器地址
    static let serverHost:String = "http://www.sscf88.com"//"http://61.183.178.86:10888/MidServer"
    //
    static let domain:String = "www.sscf88.com"
    
    //MARK:- 正则表达式验证

    //是否合法用户名
    static let userNameErrorTip:String = "用户名为英文字母和数字，长度在6到20之间"
    
    class func isUserName(userName:String) -> Bool {
        var regex = "(^[A-Za-z0-9]{6,20}$)"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(userName)
    }
    
    static let passwordErrorTip:String = "密码为英文字母和数字，长度在6到20之间"
    //是否合法密码
    class func isPassword(password:String) -> Bool {
        var regex = "(^[A-Za-z0-9]{6,20}$)"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(password)
    }
    
    static let telephoneErrorTip:String = "手机号码无效"
    //是否是手机号码
    class func isTelephone(telephone:String) -> Bool {
        var regex = "^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(telephone)
    }

    static let moneyErrorTip:String = "金额为最多两位小数的数字"
    //是否是最多两位小数的金额
    class func isMoney(money:String) -> Bool {
        var regex = "^(([1-9]\\d{0,9})|0)(\\.\\d{1,2})?$"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(money)
    }
    static let bankErrorTip:String = "银行卡号不正确"
    //是否最低8位数
    class func isBank(bankCardNo:String) ->Bool {
        var regex = "^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(bankCardNo)
    }
    
    static let stringLengthInErrorTip:String = "字符串长度不在指定的区间内"
    
    /**
    任意字符串是否在指定的长度范围内，闭区间
    
    :param: str   待测试字符串
    :param: start 长度区间开始数
    :param: end   长度区间截至数
    
    :returns: true待测试字符串在指定的长度范围内；false待测试字符串不在指定的长度范围内
    */
    class func stringLengthIn(str:String,start:Int,end:Int) -> Bool {
        var regex = "^.{\(start),\(end)}$"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(str)
    }
    
    class func isNumber(number:String) -> Bool {
        var regex = "^[1-9]\\d{0,9}$"
        var pred = NSPredicate(format: "SELF MATCHES %@", regex)
        return pred.evaluateWithObject(number)
    }
    
    //MARK:- 字符串操作
    /**
    将指定位置的字符替换为*
    
    :param: str   待处理的字符串
    :param: start 开始位置
    :param: end   结束为止
    
    :returns: 处理后的字符串
    */
    class func replaceStringToX(str:NSString,start:Int,end:Int) -> String{
        var endtemp = end;
        if str.length < start {
            return "****"
        }
        if str.length < endtemp {
            endtemp = str.length
        }
        var f = str.substringToIndex(start)
        var e = str.substringFromIndex(endtemp)
        var xin = ""
        for var i=start;i<endtemp;i++ {
            xin += "*"
        }
        return f + xin + e
    }

    //MARK:- 时间处理
    /**
    将时间戳转换为yyyy-MM-dd HH:mm:ss格式的时间字符串
    
    :param: timestamp 待转换的时间戳
    
    :returns:yyyy-MM-dd HH:mm:ss格式的时间字符串
    */
    class func dateFromTimestamp(timestamp:Double) -> String{
        var date = NSDate(timeIntervalSince1970: timestamp)
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.stringFromDate(date)
    }
    //MARK:- 时间处理
    /**
    将时间戳转换为yyyy-MM-dd 格式的时间字符串
    
    :param: timestamp 待转换的时间戳
    
    :returns:yyyy-MM-dd HH:mm:ss格式的时间字符串
    */
    class func threeDateFromTimestamp(timestamp:Double) -> String{
        var date = NSDate(timeIntervalSince1970: timestamp)
        var formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd "
        return formatter.stringFromDate(date)
    }

    /**
    将时间戳转换为MM-dd HH:mm格式的时间字符串
    
    :param: timestamp 待转换的时间戳
    
    :returns:MM-dd HH:mm格式的时间字符串
    */
    class func twoDateFromTimestamp(timestamp:Double) -> String{
        var date = NSDate(timeIntervalSince1970: timestamp)
        var formatter = NSDateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        return formatter.stringFromDate(date)
    }
    
    
    
    //MARK:- 视图美化
    /**
    为输入框所在的背景区域view加边框样式
    
    :param: view 背景区域view
    */
    class func customerBgView(view:UIView){
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor(red: 225/255.0, green: 225/255.0, blue: 225/255.0, alpha: 1.0).CGColor
    }
    /**
    为按钮加样式
    
    :param: button  按钮
    */
    class func customerButton(button:UIButton){
        button.setBackgroundImage(UIImage(named: "background"), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage(named: "button_disable"), forState: UIControlState.Highlighted)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Highlighted)
        button.setBackgroundImage(UIImage(named: "button_disable"), forState:UIControlState.Disabled)
        button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Disabled)
        
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
    }
    /**
    加下滑线
    :param: view 视图
    */
    class func addBorder(view:UIView){
        var border = CALayer()
        //border的宽度在ipad上显示不全，这里将宽度给了个很大的值
        border.frame = CGRectMake(0.0, view.layer.frame.height - 1, 10000, 1)
        border.backgroundColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1.0).CGColor
        
        view.layer.addSublayer(border)
        view.layer.masksToBounds = true//子layer不会超过父layer所在的区域
        border.setNeedsDisplay()
    }
    
    /**
    为输入框加入图标
    
    :param: textField 输入框
    :param: imageName 图标名
    */
    class func addLeftImage(textField:UITextField,imageName:String){
        var leftImageView = UIImageView(image: UIImage(named: imageName))
        leftImageView.contentMode = UIViewContentMode.Left
        leftImageView.frame = CGRectMake(0, 0, 35, textField.frame.height)
        textField.leftView = leftImageView
        textField.leftViewMode = UITextFieldViewMode.Always
    }

    
}
//MARK:- md5
extension String {
    var md5 : NSString{
        let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
        let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen);
        
        CC_MD5(str!, strLen, result);
        
        var hash = NSMutableString();
        for i in 0 ..< digestLen {
            hash.appendFormat("%02x", result[i]);
        }
        result.destroy();
        
        return String(format: hash as String)
    }
}
