Thongs is a library for making NSAttributedString creation humane. 

[![CI Status](http://img.shields.io/travis/tottakai/Thongs.svg?style=flat)](https://travis-ci.org/tottakai/Thongs)
[![Version](https://img.shields.io/cocoapods/v/Thongs.svg?style=flat)](http://cocoapods.org/pods/Thongs)
[![License](https://img.shields.io/cocoapods/l/Thongs.svg?style=flat)](http://cocoapods.org/pods/Thongs)
[![Platform](https://img.shields.io/cocoapods/p/Thongs.svg?style=flat)](http://cocoapods.org/pods/Thongs)

## Usage

```swift
import Thongs

// Create a formatter by combining different attributes, such as font, color, kerning...
// then style the string with the formatter
let red = thongs_color(UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1))
let large = thongs_font(UIFont.systemFontOfSize(28))
let kerning = thongs_kerning(1.4)
let titleFormatter = red <*> large <*> kerning
titleLabel.attributedText = titleFormatter(thongs_string("This thing right here"))


// combine string attributes with the <*> operator
// combine differently styled parts using the <+> operator
let bodyTextFont = thongs_font(UIFont.systemFontOfSize(22))
let formatter1 = bodyTextFont <*> thongs_color(UIColor(red: 46/255, green: 204/255, blue: 113/255, alpha: 1))
let formatter2 = bodyTextFont <*> thongs_color(UIColor(red: 34/255, green: 167/255, blue: 240/255, alpha: 1))
let formatter3 = bodyTextFont <*> thongs_color(UIColor(red: 232/255, green: 126/255, blue: 4/255, alpha: 1))
let formatter4 = bodyTextFont <*> thongs_color(UIColor(red: 191/255, green: 85/255, blue: 236/255, alpha: 1))
let formatter5 = bodyTextFont <*> thongs_color(UIColor(red: 245/255, green: 215/255, blue: 110/255, alpha: 1))
let formatter6 = bodyTextFont <*> thongs_color(UIColor(red: 103/255, green: 65/255, blue: 114/255, alpha: 1))

// you can apply the formatter to the string by using the ~~> operator
textBox.attributedText = formatter1 ~~> "Is lettin all the ladies know\n" <+>
    formatter2 ~~> "What guys talk about\n" <+>
    formatter3 ~~> "You know\n" <+>
    formatter4 ~~> "The finer things in life\n" <+>
    formatter5 ~~> "Hahaha\n" <+>
    formatter6 ~~> "Check it out\n"
```

<img src="Example/Media/ThongsExample.png" width="317"/>

## Installation

Thongs is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Thongs"
```

## Author

Tomi Koskinen, tomi.koskinen@reaktor.fi 

## License

Thongs is available under the MIT license. See the LICENSE file for more info.
