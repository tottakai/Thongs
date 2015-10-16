import Quick
import Nimble
import Thongs

let largeFont = UIFont.boldSystemFontOfSize(23)
let smallFont = UIFont.boldSystemFontOfSize(11)

extension String {
    var length : Int {
        return self.characters.count
    }
}

extension NSAttributedString {
    func attributesAt(loc: Int, _ len: Int) -> [NSObject : AnyObject] {
        var range = NSMakeRange(loc, len)
        return self.attributesAtIndex(loc, effectiveRange: &range)
    }
}

typealias NSAttributedStringAttribute = [NSObject : AnyObject]

func containsAttribute(key: String, _ value: String) -> MatcherFunc<NSAttributedStringAttribute> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "contain attribute <[\(key) : \(value)]>"
        do {
            if let attributeStringAttribute = try actualExpression.evaluate(),
               let attr = attributeStringAttribute[key] {
                    let attributeDescription = attr.description
                    return attributeDescription.rangeOfString(value) != nil
            }
            return false
        } catch _ {
            return false
        }
    }
}


class ThongsSpec: QuickSpec {
    override func spec() {
        describe("Thongs") {

            it("attributed string length and content is the string") {
                let example = "foo"
                expect(thongs_string(example).length) == example.length
                expect(thongs_string(example).string) == example
            }
            
            it("large font string length and content matches string length") {
                let example = "test string"
                let sample = thongs_font(largeFont)(thongs_string(example))
                
                expect(sample.length) == example.length
                expect(sample.string) == example

                let attributesOfFirstWord = sample.attributesAt(0, example.length)
                expect(attributesOfFirstWord.count) == 1
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-weight: bold"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-style: normal"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-size: 23.00pt"))
            }
            
            it("create string formatter and apply it to string") {
                let formatter = thongs_color(UIColor.redColor()) <*> thongs_font(largeFont)
                let result = formatter(thongs_string("jee"))
                
                expect(result.length) == "jee".length
                expect(result.string) == "jee"

                let attributesOfFirstWord = result.attributesAt(0, result.length)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfFirstWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 1 0 0 1"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-weight: bold"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-style: normal"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-size: 23.00pt"))
            }

            it("operator piping produced same string as function composition") {
                let example = "test string"
                let red = thongs_color(UIColor.redColor())
                let large = thongs_font(largeFont)
                let result = (red <*> large)(thongs_string(example))
                
                expect(result.length) == example.length
                expect(result.string) == example
            }
        
            it("attributed string creation with operators created intended text") {
                let example = "test string"
                let red = thongs_color(UIColor.redColor())
                let large = thongs_font(largeFont)
                let result = (red <*> large) ~~> example
                
                expect(result.length) == example.length
                expect(result.string) == example

                let attributesOfFirstWord = result.attributesAt(0, example.length)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfFirstWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 1 0 0 1"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-weight: bold"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-style: normal"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-size: 23.00pt"))
            }
            
            it("string concatenation with function composition") {
                let red = thongs_color(UIColor.redColor())
                let blue = thongs_color(UIColor.blueColor())
                let large = thongs_font(largeFont)
                let small = thongs_font(smallFont)
                let result = (red <*> large) ~~> "two" <+> (small <*> blue) ~~> "three"
                
                expect(result.length) == "twothree".length
                expect(result.string) == "twothree"
  
                let attributesOfFirstWord = result.attributesAt(0, 3)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfFirstWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 1 0 0 1"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-style: normal; font-size: 23.00pt"))

                let attributesOfSecondWord = result.attributesAt(3, 5)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfSecondWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 0 0 1 1"))
                expect(attributesOfSecondWord).to(containsAttribute("NSFont", "font-style: normal; font-size: 11.00pt"))
            }

            it("combine multiple string to text") {
                let formatter = thongs_color(UIColor.redColor()) <*> thongs_font(largeFont)
                let formatter2 = thongs_color(UIColor.blueColor()) <*> thongs_font(smallFont)
                let result = formatter ~~> "two" <+> thongs_string(" ") <+> formatter2 ~~> "three"
                
                expect(result.length) == "two three".length
                expect(result.string) == "two three"

                let attributesOfFirstWord = result.attributesAt(0, 3)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfFirstWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 1 0 0 1"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-style: normal; font-size: 23.00pt"))

                let attributesOfSpace = result.attributesAt(3, 1)
                expect(attributesOfSpace.count) == 0

                let attributesOfSecondWord = result.attributesAt(4, 5)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfSecondWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 0 0 1 1"))
                expect(attributesOfSecondWord).to(containsAttribute("NSFont", "font-style: normal; font-size: 11.00pt"))
            }
        }
    }
}
