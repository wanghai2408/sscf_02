//
//  NewPersonCenterViewController.swift
//  盛世财富
//
//  Created by 肖典 on 15/5/6.
//  Copyright (c) 2015年 sscf88. All rights reserved.
//

import Foundation
import UIKit
class NewPersonCenterViewController:UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var money: UILabel!
    @IBOutlet weak var mainTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
//        self.run(NSDictionary())
        
//        手动添加蓝色大方块
//        var img = UIImageView(image: UIImage(named: "蓝色"))
//        img.frame.size.height = 300
//        img.frame.size.width = self.view.frame.width
//        var myFinance = UILabel(frame: CGRect(x: (img.frame.width - 80)/2, y: img.frame.midY - 80, width: 80, height: 20))
//        myFinance.text = "我的资产"
//        var myMoney = UILabel(frame: CGRect(x: 0, y: myFinance.frame.maxY+10, width: self.view.frame.width, height: 60))
//        myMoney.text = "8888.88"
//        myMoney.font = UIFont(name: "Helvetica", size: 50)
//        myMoney.textAlignment = NSTextAlignment.Center
//        img.addSubview(myFinance)
//        img.addSubview(myMoney)
//        mainTable.tableHeaderView = img
//        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section.hashValue == 0{
            return 1
        }
        if section.hashValue == 1{
            return 2
        }
        if section.hashValue == 2{
            return 1
        }
        return 0
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var sec = indexPath.section.hashValue
        var row = indexPath.row
        if sec == 0 {
            if row == 0 {
                return 200
            }
        }
        if sec == 1 {
            return 44
        }
        if sec == 2 {
            return 44
        }
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell =  UITableViewCell()
        var sec = indexPath.section.hashValue
        var row = indexPath.row
        if sec == 0{
            if row == 0{
                cell = self.mainTable.dequeueReusableCellWithIdentifier("totalMoney") as UITableViewCell
            }
            
        }
        if sec == 1{
            if row == 0{
                cell = self.mainTable.dequeueReusableCellWithIdentifier("finance") as UITableViewCell
            }
            if row == 1{
                cell = self.mainTable.dequeueReusableCellWithIdentifier("record") as UITableViewCell
            }
            
        }
        if sec == 2{
            cell = self.mainTable.dequeueReusableCellWithIdentifier("secure") as UITableViewCell
        }
        return cell
    }
    //section数量
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
        
    }
    //section的header高度
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        if section == 1{
            return 10
        }
        if section == 2{
            return 10
        }
        return 10
    }
    
    func run(result:NSDictionary){
//        money.text = "100"
    }
    
}