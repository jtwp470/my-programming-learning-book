//
//  ViewController.swift
//  MoveImage
//
//  Created by jtwp470 on 7/9/15.
//  Copyright (c) 2015 jtwp470. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        // var aTouch = touches.anyObject()! as UITouch
        // http://www.techotopia.com/index.php/An_Example_Swift_iOS_8_Touch,_Multitouch_and_Tap_Application#Implementing_the_touchesEnded_Method
        var aTouch = touches.first as! UITouch
        var pos = aTouch.locationInView(view)
        
        myImage.center = pos
    }


}

