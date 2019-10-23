import Nimble
import Nimble_Snapshots
import Quick
import XCTest

class WithoutQuickTests: XCTestCase {

    func testItWorksWithXCTest() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .orange

        expect(view).to(haveValidSnapshot())
    }
}
