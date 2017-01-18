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
        
        let textBox = UITextView(frame: CGRect(x: titleLabel.frame.minX , y: titleLabel.frame.maxY + 20, width: titleLabel.frame.size.width, height: view.bounds.size.height - titleLabel.frame.maxY - 2*20))
        
        view.addSubview(titleLabel)
        view.addSubview(textBox)
        
        // Attributed string to both text boxes created with Thongs
        let red = Thongs.color(UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1))
        let large = Thongs.font(UIFont(name: "Avenir-Black", size: 28)!)
        let kerning = Thongs.kerning(1.4)
        let titleFormatter = red <*> large <*> kerning
        titleLabel.attributedText = titleFormatter(Thongs.string("This thing right here"))
        
        
        // format the first part of Sisqo's Thong song
        let bodyTextFontStyle1 = Thongs.font(UIFont(name: "Baskerville-SemiBoldItalic", size: 24)!)
        let bodyTextFontStyle2 = Thongs.font(UIFont(name: "BradleyHandITCTT-Bold", size: 16)!)
        let formatter1 = bodyTextFontStyle1 <*> Thongs.color(UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1))
        let formatter2 = bodyTextFontStyle2 <*> Thongs.color(UIColor(red: 34/255, green: 167/255, blue: 240/255, alpha: 1))
        let formatter3 = bodyTextFontStyle1 <*> Thongs.color(UIColor(red: 232/255, green: 126/255, blue: 4/255, alpha: 1))
        let formatter4 = bodyTextFontStyle2 <*> Thongs.color(UIColor(red: 191/255, green: 85/255, blue: 236/255, alpha: 1))
        let formatter5 = bodyTextFontStyle1 <*> Thongs.color(UIColor(red: 245/255, green: 215/255, blue: 110/255, alpha: 1))
        let formattedLine = Thongs.font(UIFont(name: "Courier", size: 16)!) <*> Thongs.color(UIColor(red: 103/255, green: 65/255, blue: 114/255, alpha: 1)) ~~> "Check it out\n"

        textBox.attributedText = formatter1 ~~> "Is lettin all the ladies know\n" <+>
                                 formatter2 ~~> "What guys talk about\n" <+>
                                 formatter3 ~~> "You know\n" <+>
                                 formatter4 ~~> "The finer things in life\n" <+>
                                 formatter5 ~~> "Hahaha\n" <+>
                                formattedLine
    }
}

