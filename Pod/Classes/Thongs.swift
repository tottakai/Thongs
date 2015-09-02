import Foundation

public typealias Composer = NSAttributedString -> NSAttributedString

public func thongs_string(string: String) -> NSAttributedString {
    return NSAttributedString(string: string)
    
}

public func thongs_font(font: UIFont) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.beginEditing()
        s.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributedString.length))
        s.endEditing()
        return s
    }
}

public func thongs_color(color: UIColor) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_kerning(kerning: Double) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSKernAttributeName, value: kerning, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_underline(color: UIColor, style: NSUnderlineStyle) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSUnderlineColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        s.addAttribute(NSUnderlineStyleAttributeName, value: style.rawValue, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_strikethrough(color: UIColor, style: NSUnderlineStyle) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSStrikethroughColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        s.addAttribute(NSStrikethroughStyleAttributeName, value: style.rawValue, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_concat(comp1: NSAttributedString) -> Composer {
    return { comp2 in
        var s = comp1.mutableCopy() as! NSMutableAttributedString
        s.appendAttributedString(comp2)
        return s
    }
}

// Operators

infix operator ~~> { associativity right precedence 100}

public func ~~> (composer: Composer, text: String) -> NSAttributedString {
    return { composer(thongs_string(text)) }()
}


infix operator <*> { associativity left precedence 200 }

public func <*> (composer1: Composer, composer2: Composer) -> Composer {
    return { str in
        composer2(composer1(str))
    }
}


//concat(a)(b)

infix operator <+> { associativity right precedence 30 }

public func <+> (text1: NSAttributedString, text2: NSAttributedString) -> NSAttributedString {
    return thongs_concat(text1)(text2)
}
