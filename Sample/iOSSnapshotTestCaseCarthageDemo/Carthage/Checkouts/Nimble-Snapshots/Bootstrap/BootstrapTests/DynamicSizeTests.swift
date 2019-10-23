import Bootstrap
import Nimble
import Nimble_Snapshots
import Quick

class DynamicSizeTests: QuickSpec {
    override func spec() {
        describe("in some context") {

            var view: UIView!
            let sizes = ["SmallSize": CGSize(width: 44, height: 44),
                "MediumSize": CGSize(width: 88, height: 88),
                "LargeSize": CGSize(width: 132, height: 132)]

            beforeEach {
                setNimbleTolerance(0)
                setNimbleTestFolder("tests")
            }

            context("using only frame") {
                var view: UIView!

                beforeEach {
                    view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                    view.backgroundColor = .blue
                }

                it("has a valid snapshot to all sizes") {
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes))
                }

                it("has a valid snapshot to all sizes with identifier") {
                    //expect(view).to(recordDynamicSizeSnapshot(identifier: "bootstrap", sizes: sizes))
                    expect(view).to(haveValidDynamicSizeSnapshot(identifier: "bootstrap", sizes: sizes))
                }

                it("has a valid snapshot to all sizes (using == operator)") {
                    expect(view) == snapshot(sizes: sizes)
//                    expect(view) == recordSnapshot(sizes: sizes)
                }
            }

            context("using new constrains") {
                beforeEach {
                    view = UIView()
                    view.backgroundColor = .blue
                    view.autoresizingMask = []
                    view.translatesAutoresizingMaskIntoConstraints = false
                }

                it("has a valid snapshot to all sizes") {
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
                }

                it("has a valid snapshot to all sizes (using == operator)") {
                    expect(view) == snapshot(sizes: sizes, resizeMode: .constrains)
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .constrains)
                }
            }

            context("using constrains from view") {
                beforeEach {
                    view = UIView()
                    view.backgroundColor = .blue
                    view.autoresizingMask = []
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.widthAnchor.constraint(equalToConstant: 10).isActive = true
                    view.heightAnchor.constraint(equalToConstant: 10).isActive = true
                }

                it("has a valid snapshot to all sizes") {
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes, resizeMode: .constrains))
                }

                it("has a valid snapshot to all sizes (using == operator)") {
                    expect(view) == snapshot(sizes: sizes, resizeMode: .constrains)
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .constrains)
                }
            }

            context("using block") {
                beforeEach {
                    view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                    view.backgroundColor = .blue
                }

                it("has a valid snapshot to all sizes") {
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes,
                                                                 resizeMode: .block(resizeBlock: { view, size in
                        view.frame = CGRect(origin: .zero, size: size)
                        view.layoutIfNeeded()
                    })))
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes,
//                                                              resizeMode: .block(resizeBlock: { (view, size) in
//                        view.frame = CGRect(origin: CGPoint.zero, size: size)
//                        view.layoutIfNeeded()
//                    })))
                }

                it("has a valid snapshot to all sizes (using == operator)") {
                    expect(view) == snapshot(sizes: sizes, resizeMode: .block(resizeBlock: { view, size in
                        view.frame = CGRect(origin: .zero, size: size)
                        view.layoutIfNeeded()
                    }))
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .block(resizeBlock: { (view, size) in
//                        view.frame = CGRect(origin: CGPoint.zero, size: size)
//                        view.layoutIfNeeded()
//                    }))
                }
            }

            context("using custom resizer") {
                beforeEach {
                    view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
                    view.backgroundColor = .blue
                }

                it("has a valid snapshot to all sizes") {
                    let resizer = CustomResizer()
                    expect(view).to(haveValidDynamicSizeSnapshot(sizes: sizes,
                                                                 resizeMode: .custom(viewResizer: resizer)))
                    expect(resizer.used) == 3
//                    expect(view).to(recordDynamicSizeSnapshot(sizes: sizes,
//                                                              resizeMode: .custom(ViewResizer: resizer)))
                }

                it("has a valid snapshot to all sizes (using == operator)") {
                    let resizer = CustomResizer()
                    expect(view) == snapshot(sizes: sizes, resizeMode: .custom(viewResizer: resizer))
                    expect(resizer.used) == 3
//                    expect(view) == recordSnapshot(sizes: sizes, resizeMode: .custom(ViewResizer: resizer))
                }
            }

        }
    }
}

class CustomResizer: ViewResizer {
    var used = 0

    func resize(view: UIView, for size: CGSize) {
        view.frame = CGRect(origin: .zero, size: size)
        view.layoutIfNeeded()
        used += 1
    }
}
