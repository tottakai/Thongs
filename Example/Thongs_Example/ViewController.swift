//
//  ViewController.swift
//  Thongs_Example
//
//  Created by Tomi Koskinen on 17/10/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = UIColor.blueColor()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 44, width: 350, height: 40))
        titleLabel.backgroundColor = UIColor.redColor()
        titleLabel.text = "jee"
        
        view.addSubview(titleLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

