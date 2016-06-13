//
//  ViewController.swift
//  TestKVOInSwift
//
//  Created by ying on 16/6/8.
//  Copyright © 2016年 ying. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet weak var labelFirstName: UILabel!
    @IBOutlet weak var labelLastName: UILabel!
    @IBOutlet weak var labelFullName: UILabel!
    
    @IBOutlet weak var labelAddress: UILabel!
    
    private var person: Person?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let address = Address(firstLine: "China", secondLine: "Shanghai")
        self.person = Person(firstName: "Peter", lastName: "Cook", address: address)
        
        //NSKeyValueObservingOptions.New， 这个选项代表我们监听 KVO 每次属性改变后的新值
        //NSKeyValueObservingOptions.New 每次属性改变后的新值
        //NSKeyValueObservingOptions.Old 每次属性改变之前的旧值
        self.person?.addObserver(self, forKeyPath: "firstName", options: NSKeyValueObservingOptions.New, context: nil)
        self.person?.addObserver(self, forKeyPath: "lastName", options: NSKeyValueObservingOptions.New, context: nil)
         self.person?.addObserver(self, forKeyPath: "fullName", options: NSKeyValueObservingOptions.New, context: nil)
        
        //KVC方式取值
        labelFirstName.text = person!.valueForKey("firstName") as? String
        labelLastName.text = person!.valueForKey("lastName") as? String
        labelFullName.text = person!.valueForKey("fullName") as? String
        
        //KVC获取属性时对象时的值
        let firstLine = person!.valueForKeyPath("address.firstLine")!
        let secondLine = person!.valueForKeyPath("address.secondLine")!
        labelAddress.text = "\(firstLine) \(secondLine)"
        
        //labelFirstName.text = person?.firstName
        //labelLastName.text = person?.lastName
        //labelFullName.text = person?.fullName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        if keyPath == "firstName" {
            if let firstName = change?[NSKeyValueChangeNewKey] as? String {
                self.labelFirstName?.text = firstName
            }
        }
        else if keyPath == "lastName" {
            if let lastName = change?[NSKeyValueChangeNewKey] as? String {
                self.labelLastName?.text = lastName
            }
        }
        else if keyPath == "fullName" {
            if let fullName = change?[NSKeyValueChangeNewKey] as? String {
                self.labelFullName?.text = fullName
            }
        }
        else {
            
        }
    }
    @IBAction func changeLabel(sender: UIButton) {
        
        self.person?.firstName = "Zi"
        self.person?.lastName = "Feng"
    }
    
    deinit {
        super.viewDidLoad()
        //将 KVO 通知的删除掉(如果没有正确的清除掉 KVO 通知，程序可能会在某些时候意外的崩溃)
        self.person?.removeObserver(self, forKeyPath: "firstName")
        self.person?.removeObserver(self, forKeyPath: "lastName")
        self.person?.removeObserver(self, forKeyPath: "fullName")
    }

}

