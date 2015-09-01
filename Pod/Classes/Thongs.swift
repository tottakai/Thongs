import Foundation

public typealias Composer = NSAttributedString -> NSAttributedString

public func ThongsString(string: String) -> NSAttributedString {
    return NSAttributedString(string: string)
    
}

public func ThongsFont(font: UIFont) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.beginEditing()
        s.addAttribute(NSFontAttributeName, value: font, range: NSMakeRange(0, attributedString.length))
        s.endEditing()
        return s
    }
}

public func ThongsColor(color: UIColor) -> Composer {
    return { attributedString in
        var s = attributedString.mutableCopy() as! NSMutableAttributedString
        s.addAttribute(NSForegroundColorAttributeName, value: color, range: NSMakeRange(0, attributedString.length))
        return s
    }
}

public func ThongsConcat(comp1: NSAttributedString) -> Composer {
    return { comp2 in
        var s = comp1.mutableCopy() as! NSMutableAttributedString
        s.appendAttributedString(comp2)
        return s
    }
}

// Operators

infix operator ~~> { associativity right }

public func ~~> (composer: Composer, text: String) -> NSAttributedString {
    return { composer(ThongsString(text)) }()
}


infix operator <*> { associativity left }

public func <*> (composer1: Composer, composer2: Composer) -> Composer {
    return { str in
        composer2(composer1(str))
    }
}

//concat(a)(b)

infix operator <+> { associativity left }

public func <+> (text1: NSAttributedString, text2: NSAttributedString) -> NSAttributedString {
    return ThongsConcat(text1)(text2)
}
