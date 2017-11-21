import UIKit
import XCTest
import Thongs


let largeFont = UIFont(name: "Avenir-Light", size: 23)!
let smallFont = UIFont(name: "Courier", size: 11)!

extension String {
    var length : Int {
        return self.count
    }
}

extension NSAttributedString {
    func attributesAt(_ loc: Int, _ len: Int) -> [AnyHashable: Any] {
        var range = NSMakeRange(loc, len)
        return self.attributes(at: loc, effectiveRange: &range)
    }
}


func fontAttribute(_ referenceFont: UIFont) -> (AnyHashable, Any) -> Bool {
    return { (key: AnyHashable, value: Any) in
        guard let attributeName = key.base as? NSString, attributeName == "NSFont" else {
            return false
        }
        
        guard let font = value as? UIFont else {
            return false
        }
        
        return font == referenceFont
    }
}

func colorAttribute(_ referenceColor: UIColor) -> (AnyHashable, Any) -> Bool {
    return { (key: AnyHashable, value: Any) in
        guard let attributeName = key.base as? NSString, attributeName == "NSColor" else {
            return false
        }
        
        guard let color = value as? UIColor else {
            return false
        }
        
        return color == referenceColor
    }
}


class Tests: XCTestCase {
    
    func testAttributed_string_length_and_content_is_the_string() {
        let example = "foo"
        XCTAssert(Thongs.string(example).length == example.length)
        XCTAssert(Thongs.string(example).string == example)
    }

    func testLarge_font_string_length_and_content_matches_string_length() {
        let example = "test string"
        let sample = Thongs.font(largeFont)(Thongs.string(example))
        
        XCTAssert(sample.length == example.length)
        XCTAssert(sample.string == example)
        
        let attributesOfFirstWord = sample.attributesAt(0, example.length)
        XCTAssert(attributesOfFirstWord.count == 1)
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute(largeFont)))
    }

    func testCreate_string_formatter_and_apply_it_to_string() {
        let formatter = Thongs.color(UIColor.red) <*> Thongs.font(largeFont)
        let result = formatter(Thongs.string("jee"))
        
        XCTAssert(result.length == "jee".length)
        XCTAssert(result.string == "jee")
        
        let attributesOfFirstWord = result.attributesAt(0, result.length)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute(UIColor.red)))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute(largeFont)))
    }
    
    func testOperator_piping_produced_same_string_as_function_composition() {
        let example = "test string"
        let red = Thongs.color(UIColor.red)
        let large = Thongs.font(largeFont)
        let result = (red <*> large)(Thongs.string(example))
        
        XCTAssert(result.length == example.length)
        XCTAssert(result.string == example)
    }
 
    func testAttributed_string_creation_with_operators_created_intended_text() {
        let example = "test string"
        let red = Thongs.color(UIColor.red)
        let large = Thongs.font(largeFont)
        let result = (red <*> large) ~~> example
        
        XCTAssert(result.length == example.length)
        XCTAssert(result.string == example)
        
        let attributesOfFirstWord = result.attributesAt(0, example.length)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute(UIColor.red)))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute(largeFont)))
    }
    
    func testString_concatenation_with_function_composition() {
        let red = Thongs.color(UIColor.red)
        let blue = Thongs.color(UIColor.blue)
        let large = Thongs.font(largeFont)
        let small = Thongs.font(smallFont)
        let result = (red <*> large) ~~> "two" <+> (small <*> blue) ~~> "three"
        
        XCTAssert(result.length == "twothree".length)
        XCTAssert(result.string == "twothree")
        
        let attributesOfFirstWord = result.attributesAt(0, 3)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute(UIColor.red)))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute(largeFont)))
        
        let attributesOfSecondWord = result.attributesAt(3, 5)
        XCTAssert(attributesOfSecondWord.count == 2)
        XCTAssert(attributesOfSecondWord.contains(where: colorAttribute(UIColor.blue)))
        XCTAssert(attributesOfSecondWord.contains(where: fontAttribute(smallFont)))
    }
    
    func testCombine_multiple_string_to_text() {
        let formatter = Thongs.color(UIColor.red) <*> Thongs.font(largeFont)
        let result = formatter ~~> "two" <+> 
            Thongs.string(" ") <+> 
            Thongs.color(UIColor.blue) <*> Thongs.font(smallFont) ~~> "three"
        
        XCTAssert(result.length == "two three".length)
        XCTAssert(result.string == "two three")
        
        let attributesOfFirstWord = result.attributesAt(0, 3)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute(UIColor.red)))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute(largeFont)))
        
        let attributesOfSpace = result.attributesAt(3, 1)
        XCTAssert(attributesOfSpace.count == 0)
        
        let attributesOfSecondWord = result.attributesAt(4, 5)
        XCTAssert(attributesOfSecondWord.count == 2)
        XCTAssert(attributesOfSecondWord.contains(where: colorAttribute(UIColor.blue)))
        XCTAssert(attributesOfSecondWord.contains(where: fontAttribute(smallFont)))
    }
}
