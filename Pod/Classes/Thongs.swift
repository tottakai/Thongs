import Foundation

let large = UIFont.boldSystemFontOfSize(23)
let small = UIFont.boldSystemFontOfSize(11)

typealias Composer = NSAttributedString -> NSAttributedString

func string(string: String) -> NSAttributedString {
    return NSAttributedString(string: string)
    
}

func font(font: UIFont) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.beginEditing()
        s.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributedString.length))
        s.endEditing()
        return s
    }
}

func color(color: UIColor) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

func concat(comp1: NSAttributedString) -> Composer {
    return { comp2 in
        var s = comp1.mutableCopy() as! NSMutableAttributedString
        s.appendAttributedString(comp2)
        return s
    }
}

//let a = color(UIColor.redColor())(font(small)(string("bar")))
//let b = font(large)(string("foo"))
//concat(a)(b)
