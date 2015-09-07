import Quick
import Nimble
import Thongs

let largeFont = UIFont.boldSystemFontOfSize(23)
let smallFont = UIFont.boldSystemFontOfSize(11)

extension NSAttributedString {
    func attributesAt(loc: Int, _ len: Int) -> [NSObject : AnyObject] {
        var range = NSMakeRange(loc, len)
        return self.attributesAtIndex(loc, effectiveRange: &range)
    }
}

typealias NSAttributedStringAttribute = [NSObject : AnyObject]

func containsAttribute(key: String, value: String) -> MatcherFunc<NSAttributedStringAttribute> {
    return MatcherFunc { actualExpression, failureMessage in
        failureMessage.postfixMessage = "contain attribute <[\(key) : \(value)]>"
        // expect(attrs["NSColor"]!.description) == "UIDeviceRGBColorSpace 1 0 0 1"
        let attributeDescription = actualExpression.evaluate()![key]!.description
        return attributeDescription.rangeOfString(value) != nil
    }
}


class ThongsSpec: QuickSpec {
    override func spec() {
        describe("Thongs") {

            it("attributed string length is equal to created string length") {
                let example = "foo"
                expect(thongs_string(example).length) == count(example)
            }
            
            it("large font string length matches string length") {
                let example = "test string"
                let sample = thongs_font(largeFont)(thongs_string(example))
                expect(sample.length) == count(example)
            }

            it("operator piping produced same string as function composition") {
                let example = "test string"
                let red = thongs_color(UIColor.redColor())
                let large = thongs_font(largeFont)
                let result = (red <*> large)(thongs_string(example))
                
                expect(result.length) == count(example)
                expect(result.string) == example
            }
        
            it("function composition") {
                let example = "test string"
                let red = thongs_color(UIColor.redColor())
                let large = thongs_font(largeFont)
                let result = (red <*> large) ~~> example
                
                expect(result.length) == count(example)
                expect(result.string) == example
            }
            
            it("string concatenation with function composition") {
                let red = thongs_color(UIColor.redColor())
                let blue = thongs_color(UIColor.blueColor())
                let large = thongs_font(largeFont)
                let small = thongs_font(smallFont)
                let result = (red <*> large) ~~> "two" <+> (small <*> blue) ~~> "three"
                
                expect(result.length) == count("twothree")
                expect(result.string) == "twothree"
  
                let attributesOfFirstWord = result.attributesAt(0, 3)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfFirstWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 1 0 0 1"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-family: \".HelveticaNeueInterface-MediumP4\"; font-weight: bold"))
                expect(attributesOfFirstWord).to(containsAttribute("NSFont", "font-style: normal; font-size: 23.00pt"))

                let attributesOfSecondWord = result.attributesAt(3, 5)
                expect(attributesOfFirstWord.count) == 2
                expect(attributesOfSecondWord).to(containsAttribute("NSColor", "UIDeviceRGBColorSpace 0 0 1 1"))
                expect(attributesOfSecondWord).to(containsAttribute("NSFont", "font-family: \".HelveticaNeueInterface-MediumP4\"; font-weight: bold"))
                expect(attributesOfSecondWord).to(containsAttribute("NSFont", "font-style: normal; font-size: 11.00pt"))
            }

            it("create string formatter") {
                let formatter = thongs_color(UIColor.redColor()) <*> thongs_font(largeFont)
                let formatter2 = thongs_color(UIColor.blueColor()) <*> thongs_font(smallFont)
                let result = formatter ~~> "two" <+> thongs_string(" ") <+> formatter2 ~~> "three"
                
                expect(result.length) == count("two three")
                expect(result.string) == "two three"
            }
            it("create string formatter and apply it to string") {
                let formatter = thongs_color(UIColor.redColor()) <*> thongs_font(largeFont)
                let result = formatter(thongs_string("jee"))
                
                expect(result.length) == count("jee")
                expect(result.string) == "jee"
            }

        }
    }
}
