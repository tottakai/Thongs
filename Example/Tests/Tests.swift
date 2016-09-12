import UIKit
import XCTest
import Thongs


let largeFont = UIFont.boldSystemFont(ofSize: 23)
let smallFont = UIFont.boldSystemFont(ofSize: 11)

extension String {
    var length : Int {
        return self.characters.count
    }
}

extension NSAttributedString {
    func attributesAt(_ loc: Int, _ len: Int) -> [AnyHashable: Any] {
        var range = NSMakeRange(loc, len)
        return self.attributes(at: loc, effectiveRange: &range)
    }
}


func fontAttribute(_ description: String) -> (AnyHashable, Any) -> Bool {
    return { (key: AnyHashable, value: Any) in
        guard let attributeName = key.base as? String, attributeName == "NSFont" else {
            return false
        }
        
        guard let font = value as? UIFont else {
            return false
        }
        
        let parts = font.description.characters.split(separator: ";")
        return parts.contains(where: { part in
            return String(part).trimmingCharacters(in: CharacterSet.whitespaces) == description
        })
    }
}

func colorAttribute(_ description: String) -> (AnyHashable, Any) -> Bool {
    return { (key: AnyHashable, value: Any) in
        guard let attributeName = key.base as? String, attributeName == "NSColor" else {
            return false
        }
        
        guard let color = value as? UIColor else {
            return false
        }
        
        return color.description == description
    }
}


class Tests: XCTestCase {
    
    func testAttributed_string_length_and_content_is_the_string() {
        let example = "foo"
        XCTAssert(thongs_string(example).length == example.length)
        XCTAssert(thongs_string(example).string == example)
    }

    func testLarge_font_string_length_and_content_matches_string_length() {
        let example = "test string"
        let sample = thongs_font(largeFont)(thongs_string(example))
        
        XCTAssert(sample.length == example.length)
        XCTAssert(sample.string == example)
        
        let attributesOfFirstWord = sample.attributesAt(0, example.length)
        XCTAssert(attributesOfFirstWord.count == 1)
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-weight: bold")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-size: 23.00pt")))
    }

    func testCreate_string_formatter_and_apply_it_to_string() {
        let formatter = thongs_color(UIColor.red) <*> thongs_font(largeFont)
        let result = formatter(thongs_string("jee"))
        
        XCTAssert(result.length == "jee".length)
        XCTAssert(result.string == "jee")
        
        let attributesOfFirstWord = result.attributesAt(0, result.length)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute("UIExtendedSRGBColorSpace 1 0 0 1")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-weight: bold")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-size: 23.00pt")))
    }
    
    func testOperator_piping_produced_same_string_as_function_composition() {
        let example = "test string"
        let red = thongs_color(UIColor.red)
        let large = thongs_font(largeFont)
        let result = (red <*> large)(thongs_string(example))
        
        XCTAssert(result.length == example.length)
        XCTAssert(result.string == example)
    }
 
    func testAttributed_string_creation_with_operators_created_intended_text() {
        let example = "test string"
        let red = thongs_color(UIColor.red)
        let large = thongs_font(largeFont)
        let result = (red <*> large) ~~> example
        
        XCTAssert(result.length == example.length)
        XCTAssert(result.string == example)
        
        let attributesOfFirstWord = result.attributesAt(0, example.length)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute("UIExtendedSRGBColorSpace 1 0 0 1")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-weight: bold")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-size: 23.00pt")))
    }
    
    func testString_concatenation_with_function_composition() {
        let red = thongs_color(UIColor.red)
        let blue = thongs_color(UIColor.blue)
        let large = thongs_font(largeFont)
        let small = thongs_font(smallFont)
        let result = (red <*> large) ~~> "two" <+> (small <*> blue) ~~> "three"
        
        XCTAssert(result.length == "twothree".length)
        XCTAssert(result.string == "twothree")
        
        let attributesOfFirstWord = result.attributesAt(0, 3)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute("UIExtendedSRGBColorSpace 1 0 0 1")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-size: 23.00pt")))
        
        let attributesOfSecondWord = result.attributesAt(3, 5)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfSecondWord.contains(where: colorAttribute("UIExtendedSRGBColorSpace 0 0 1 1")))
        XCTAssert(attributesOfSecondWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfSecondWord.contains(where: fontAttribute("font-size: 11.00pt")))
    }
    
    func testCombine_multiple_string_to_text() {
        let formatter = thongs_color(UIColor.red) <*> thongs_font(largeFont)
        let formatter2 = thongs_color(UIColor.blue) <*> thongs_font(smallFont)
        let result = formatter ~~> "two" <+> thongs_string(" ") <+> formatter2 ~~> "three"
        
        XCTAssert(result.length == "two three".length)
        XCTAssert(result.string == "two three")
        
        let attributesOfFirstWord = result.attributesAt(0, 3)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfFirstWord.contains(where: colorAttribute("UIExtendedSRGBColorSpace 1 0 0 1")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfFirstWord.contains(where: fontAttribute("font-size: 23.00pt")))
        
        let attributesOfSpace = result.attributesAt(3, 1)
        XCTAssert(attributesOfSpace.count == 0)
        
        let attributesOfSecondWord = result.attributesAt(4, 5)
        XCTAssert(attributesOfFirstWord.count == 2)
        XCTAssert(attributesOfSecondWord.contains(where: colorAttribute("UIExtendedSRGBColorSpace 0 0 1 1")))
        XCTAssert(attributesOfSecondWord.contains(where: fontAttribute("font-style: normal")))
        XCTAssert(attributesOfSecondWord.contains(where: fontAttribute("font-size: 11.00pt")))
    }
}
