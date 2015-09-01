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
