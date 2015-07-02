//
//  ViewController.swift
//  Hello
//
//  Created by 大津 真 on 2014/12/08.
//  Copyright (c) 2014年 Gmachine. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

    @IBAction func yellowButtonPressed(sender: AnyObject) {
        view.backgroundColor = UIColor.yellowColor()
    }
    @IBAction func whiteButtonPressed(sender: AnyObject) {
        // view.backgroundColor = UIColor.whiteColor()
    }
    
}

