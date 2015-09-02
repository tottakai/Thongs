import Quick
import Nimble
import Thongs

let largeFont = UIFont.boldSystemFontOfSize(23)
let smallFont = UIFont.boldSystemFontOfSize(11)


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
