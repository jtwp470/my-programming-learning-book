//
//  ViewController.swift
//  Doll2Yen
//
//  Created by jtwp470 on 7/9/15.
//  Copyright (c) 2015 jtwp470. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let kDoll = "DollKey"
    let kRate = "RateKey"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        dollText.text = userDefaults.stringForKey(kDoll)
        rateText.text = userDefaults.stringForKey(kRate)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func saveDefault() {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        // ドルとレートをデフォルトに保存
        userDefaults.setObject(dollText.text, forKey: kDoll)
        userDefaults.setObject(rateText.text, forKey: kRate)
        userDefaults.synchronize()
    }
    @IBOutlet weak var dollText: UITextField!
    @IBOutlet weak var rateText: UITextField!
    
    @IBAction func calc(sender: AnyObject) {
        let doll = (dollText.text as NSString).doubleValue
        let rate = (rateText.text as NSString).doubleValue
        yenLabel.text = "\(doll * rate)"
        
        // ユーザーデフォルトを保存
        saveDefault()
    }
    @IBOutlet weak var yenLabel: UILabel!
    
    override class func initialize() {
        let defaultValue = ["DollKey": "10", "RateKey": "116.5"]
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.registerDefaults(defaultValue)
    }
}