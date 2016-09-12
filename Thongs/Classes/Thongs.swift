import Foundation

public typealias Composer = (NSAttributedString) -> NSAttributedString

public func thongs_string(_ string: String) -> NSAttributedString {
    return NSAttributedString(string: string)
    
}

public func thongs_font(_ font: UIFont) -> Composer {
    return { attributedString in
        let s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.beginEditing()
        s.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributedString.length))
        s.endEditing()
        return s
    }
}

public func thongs_color(_ color: UIColor) -> Composer {
    return { attributedString in
        let s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_kerning(_ kerning: Double) -> Composer {
    return { attributedString in
        let s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSKernAttributeName, value: kerning, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_underline(_ color: UIColor, style: NSUnderlineStyle) -> Composer {
    return { attributedString in
        let s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSUnderlineColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        s.addAttribute(NSUnderlineStyleAttributeName, value: style.rawValue, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_strikethrough(_ color: UIColor, style: NSUnderlineStyle) -> Composer {
    return { attributedString in
        let s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSStrikethroughColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        s.addAttribute(NSStrikethroughStyleAttributeName, value: style.rawValue, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func thongs_concat(_ comp1: NSAttributedString) -> Composer {
    return { comp2 in
        let s = comp1.mutableCopy() as! NSMutableAttributedString
        s.append(comp2)
        return s
    }
}

// Operators

infix operator ~~> { associativity left precedence 190}

public func ~~> (composer: Composer, text: String) -> NSAttributedString {
    return { composer(thongs_string(text)) }()
}


infix operator <*> { associativity left precedence 200 }

public func <*> (composer1: @escaping Composer, composer2: @escaping Composer) -> Composer {
    return { str in
        composer2(composer1(str))
    }
}


//concat(a)(b)

infix operator <+> { associativity right precedence 180 }

public func <+> (text1: NSAttributedString, text2: NSAttributedString) -> NSAttributedString {
    return thongs_concat(text1)(text2)
}
