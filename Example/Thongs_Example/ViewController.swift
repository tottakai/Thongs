//
//  ViewController.swift
//  Thongs_Example
//
//  Created by Tomi Koskinen on 17/10/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import UIKit
import Thongs

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 44, width: view.bounds.size.width-2*20, height: 40))
        
        let textBox = UITextView(frame: CGRect(x: CGRectGetMinX(titleLabel.frame) , y: CGRectGetMaxY(titleLabel.frame) + 20, width: titleLabel.frame.size.width, height: view.bounds.size.height - CGRectGetMaxY(titleLabel.frame) - 2*20))
        
        view.addSubview(titleLabel)
        view.addSubview(textBox)
        
        // Attributed string to both text boxes created with Thongs
        let red = thongs_color(UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1))
        let large = thongs_font(UIFont.systemFontOfSize(30))
        let kerning = thongs_kerning(1.4)
        titleLabel.attributedText = (red <*> large <*> kerning)(thongs_string("This thing right here"))
        
        let blue = thongs_color(UIColor(red: 46/255, green: 204/255, blue: 133/255, alpha: 1))
        let smallFont = thongs_font(UIFont.systemFontOfSize(11))
        let res = (red <*> large) ~~> "Is lettin all the ladies know" <+> (smallFont <*> blue) ~~> "What guys talk about"
        textBox.attributedText = res
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

