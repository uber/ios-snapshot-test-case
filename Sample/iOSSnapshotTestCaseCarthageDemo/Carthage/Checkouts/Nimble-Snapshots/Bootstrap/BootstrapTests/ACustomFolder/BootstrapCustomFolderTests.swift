import Nimble
import Nimble_Snapshots
import Quick

class BootstrapCustomFormatTests: QuickSpec {
    override func spec() {
        describe("in some context") {
            var view: UIView!

            beforeEach {
                setNimbleTestFolder("CustomFolder")
                view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
                view.backgroundColor = .blue
            }

            it("fails to find the snapshots due to the custom folder") {
                expect(view).notTo(haveValidSnapshot(named: "something custom"))
            }

            it("finds the snapshots using a custom images directory") {
                expect(view).to(haveValidSnapshot())
            }

            it("finds device agnostic snapshots with custom images directory") {
                expect(view).to(haveValidDeviceAgnosticSnapshot())
            }
        }
    }
}
