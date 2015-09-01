import Quick
import Nimble
import Thongs

let largeFont = UIFont.boldSystemFontOfSize(23)
let smallFont = UIFont.boldSystemFontOfSize(11)


class ThongsSpec: QuickSpec {
    override func spec() {
        describe("Thongs") {

            it("attributed string length is equal to created string length") {
//                let a = color(UIColor.redColor())(font(small)(string("bar")))
                //let b = font(large)(string("foo"))
                //concat(a)(b)
                let example = "foo"
                expect(ThongsString(example).length) == count(example)
            }
            
            it("large font string length matches string length") {
                let example = "test string"
                let sample = ThongsFont(largeFont)(ThongsString(example))
                expect(sample.length) == count(example)
            }

            it("operator piping produced same string as function composition") {
                let example = "test string"
                let red = ThongsColor(UIColor.redColor())
                let large = ThongsFont(largeFont)
                let result = (red <*> large)(ThongsString(example))
                
                expect(result.length) == count(example)
                expect(result.string) == example
            }
        
            it("function composition") {
                let example = "test string"
                let red = ThongsColor(UIColor.redColor())
                let large = ThongsFont(largeFont)
                let result = (red <*> large) ~~> example
                
                expect(result.length) == count(example)
                expect(result.string) == example
            }
            
            it("string concatenation with function composition") {
                let part1 = "two"
                let part2 = "three"
                let red = ThongsColor(UIColor.redColor())
                let blue = ThongsColor(UIColor.blueColor())
                let large = ThongsFont(largeFont)
                let small = ThongsFont(smallFont)
                let result1 = (red <*> large) ~~> part1
                let result2 = (small <*> blue) ~~> part2
                let result = result1 <+> result2
                
                expect(result.length) == count(part1) + count(part2)
                expect(result.string) == part1 + part2
            }
        }
    }
}
