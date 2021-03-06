	//
//  AppDelegate.swift
//  盛世财富
//
//  Created by mo on 15-3-12.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//
    
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        NSLog("didFinishLaunchingWithOptions")
        // Override point for customization after application launch.
        var storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        //应用第一次启动的时候，加入用户引导页面
        if !NSUserDefaults.standardUserDefaults().boolForKey("firstLaunch") {
            
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "firstLaunch")
            
            NSUserDefaults.standardUserDefaults().setBool(false, forKey: "showLockPassword")
            
            window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("UserGuideViewController") as! UserGuideViewController
            
        }else{
            window?.rootViewController = storyboard.instantiateViewControllerWithIdentifier("tabBarViewController") as!TabBarViewController
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "showLockPassword")
        }
        
        
        //设置状态栏字体颜色和背景颜色
        var appearance = UINavigationBar.appearance()
        var red:CGFloat = 64/255.0
        var green:CGFloat = 166/255.0
        var blue:CGFloat = 255/255.0
        var color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        appearance.barTintColor = color
        
//        var colorLayer = CALayer()
//        colorLayer.opacity = Float(0.4)
//        appearance.layer.addSublayer(colorLayer)
//        var opacity:CGFloat = 0.4
//        var minVal:CGFloat = red
//        if self.convertValue(minVal, opacity: opacity) < 0 {
//            opacity = self.minOpacityForValue(minVal)
//        }
//        
//        colorLayer.opacity = Float(opacity)
//        red = self.convertValue(red, opacity: opacity)
//        green = self.convertValue(green, opacity: opacity)
//        blue = self.convertValue(blue, opacity: opacity)
//        
//        red = max(min(1.0,red),0)
//        green = max(min(1.0,green),0)
//        blue = max(min(1.0,blue),0)
//       println("red = \(red)  green=\(green)  blue=\(blue)")
//
//        colorLayer.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 0.66).CGColor
//        
//        //appearance.layoutSubviews()
//        colorLayer.frame = CGRectMake(0, -20, appearance.frame.width, appearance.frame.height + 20)
        
        
        
        
        
        
        
        
        
        
        
        appearance.tintColor = UIColor.whiteColor()
        appearance.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        
        //自定义返回按钮
        //修改返回按钮的颜色
        UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
        var backButtonImage = UIImage(named: "1_75")
//        backButtonImage?.resizableImageWithCapInsets(UIEdgeInsetsMake(0, 30, 0, 0))
//        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backButtonImage, forState: UIControlState.Normal, barMetrics: UIBarMetrics.Default)
        //将返回按钮的文字position设置不在屏幕上显示
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(CGFloat(NSInteger.min), CGFloat(NSInteger.min)), forBarMetrics: UIBarMetrics.Default)
//        var customerBackButtonItem = UIView()
//        customerBackButtonItem.sizeToFit()
//        customerBackButtonItem.addSubview(UIImageView(image: backButtonImage))
//        UIBarButtonItem.appearance().customView = customerBackButtonItem
        
        
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//        NSLog("applicationWillEnterForeground")
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

        
        //设置手势密码
//        if NSUserDefaults.standardUserDefaults().boolForKey("showLockPassword") {
//            //第一次运行的时候不显示手势密码
//            
//            //手势解锁相关
//            if let pswd  = LLLockPassword.loadLockPassword(){
//                
//                self.showLLLockViewController(LLLockViewTypeCheck)
//            }else{
//                self.showLLLockViewController(LLLockViewTypeCreate)
//                
//            }
//        }
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
    }
    
    func showLLLockViewController(type:LLLockViewType){
        //if self.window!.rootViewController!.presentingViewController == nil {
            var lockVc = LLLockViewController()
            lockVc.nLockViewType = type
            lockVc.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            var root = self.window?.rootViewController
            //NSLog("root:%@",root!)
            self.window?.rootViewController?.presentViewController(lockVc, animated: true, completion: nil)
        //}
    }

    
    func minOpacityForValue(value:CGFloat) -> CGFloat {
        return (0.4 - 0.4 * value) / (0.6 * value + 0.4);
    }
    
    func convertValue(value:CGFloat,opacity:CGFloat) -> CGFloat {
        return 0.4 * value / opacity + 0.6 * value - 0.4 / opacity + 0.4;
    }

}

