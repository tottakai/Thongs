// https://github.com/Quick/Quick

import Quick
import Nimble
import Thongs

let large = UIFont.boldSystemFontOfSize(23)
let small = UIFont.boldSystemFontOfSize(11)


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
                let sample = ThongsFont(large)(ThongsString(example))
                expect(sample.length) == count(example)
            }
        }
    }
}
