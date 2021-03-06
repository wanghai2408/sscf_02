//
//  ModifyPinPasswordViewController.swift
//  盛世财富
//  修改交易密码
//  Created by 云笺 on 15/5/17.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import UIKit

class ModifyPinPasswordViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var oldPinPasswordTextField: UITextField!
    
    @IBOutlet weak var oldPinPassLabel: UILabel!
    
    @IBOutlet weak var newPinPassLabel: UILabel!
    @IBOutlet weak var newPinPasswordTextField: UITextField!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var confirmPassLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        oldPinPasswordTextField.delegate = self
        newPinPasswordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        
        Common.customerBgView(bgView)
        Common.customerButton(okButton)
        Common.addBorder(oldPinPassLabel)
        Common.addBorder(oldPinPasswordTextField)
        Common.addBorder(newPinPassLabel)
        Common.addBorder(newPinPasswordTextField)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modifyTapped(sender: UIButton) {
        resignAll()
        var oldpass = oldPinPasswordTextField.text
        var newpass = newPinPasswordTextField.text
        var confirmpass = confirmPasswordTextField.text
        if oldpass.isEmpty {
            AlertView.showMsg("请输入原密码", parentView: self.view)
            return
        }
        if !Common.isPassword(oldpass) {
            AlertView.showMsg(Common.passwordErrorTip, parentView: self.view)
            return
        }
        if newpass.isEmpty {
            AlertView.showMsg("请输入新密码", parentView: self.view)
            return
        }
        if !Common.isPassword(newpass) {
            AlertView.showMsg(Common.passwordErrorTip, parentView: self.view)
            return
        }
        if confirmpass.isEmpty {
            AlertView.showMsg("请输入确认密码", parentView: self.view)
            return
        }
        if newpass != confirmpass {
            AlertView.showMsg("两次密码不一致", parentView: self.view)
            return
        }
        //其他输入限制再加
        //检查手机网络
        var reach = Reachability(hostName: Common.domain)
        reach.unreachableBlock = {(r:Reachability!) -> Void in
            //NSLog("网络不可用")
            dispatch_async(dispatch_get_main_queue(), {

                AlertView.alert("提示", message: "网络连接有问题，请检查网络是否连接", buttonTitle: "确定", viewController: self)
            })
        }
        
        reach.reachableBlock = {(r:Reachability!) -> Void in
           //NSLog("网络可用")
            dispatch_async(dispatch_get_main_queue(), {
                var manager = AFHTTPRequestOperationManager()
                var url = Common.serverHost + "/App-Ucenter-setPinPassWord"
                var token = NSUserDefaults.standardUserDefaults().objectForKey("token") as? String
                var params = ["pin_pass":oldpass,"newPinpass":newpass,"to":token]
                loading.startLoading(self.view)
                manager.responseSerializer.acceptableContentTypes = NSSet(array: ["text/html"]) as Set<NSObject>
                manager.POST(url, parameters: params,
                    success: { (op:AFHTTPRequestOperation!, data:AnyObject!) -> Void in
                        loading.stopLoading()
                        var result = data as! NSDictionary
                        var code = result["code"] as! Int
                        if code == -1 {
                            AlertView.showMsg("请登录后再试", parentView: self.view)
                        }else if code == 0 {
                            AlertView.showMsg(result["message"] as! String, parentView: self.view)
                        }else if code == 200 {
                            AlertView.showMsg("修改交易密码成功", parentView: self.view)
                            NSThread.sleepForTimeInterval(3)
                            self.navigationController?.popViewControllerAnimated(true)
                        }
                        
                    },failure: { (op:AFHTTPRequestOperation!, error:NSError!) -> Void in
                        loading.stopLoading()
                        AlertView.alert("提示", message: "服务器错误", buttonTitle: "确定", viewController: self)
                    }
                )

                
            })
        }
      
        reach.startNotifier()
    }


    //MARK:- 隐藏键盘
    override func viewWillAppear(animated: Bool) {
        DaiDodgeKeyboard.addRegisterTheViewNeedDodgeKeyboard(self.view)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        DaiDodgeKeyboard.removeRegisterTheViewNeedDodgeKeyboard()
        super.viewWillDisappear(animated)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if range.location >= 20 {
            return false
        }
        return true
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == oldPinPasswordTextField {
            newPinPasswordTextField.becomeFirstResponder()
        }else if textField == newPinPasswordTextField{
            confirmPasswordTextField.becomeFirstResponder()
        }else if textField == confirmPasswordTextField{
            resignAll()
        }
        
        return true
    }
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        resignAll()
    }
    
    func resignAll() {
        oldPinPasswordTextField.resignFirstResponder()
        newPinPasswordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
    }
}
