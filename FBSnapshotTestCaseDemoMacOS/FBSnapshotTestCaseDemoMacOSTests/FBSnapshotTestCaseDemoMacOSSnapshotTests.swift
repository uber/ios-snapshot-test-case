//
//  FBSnapshotTestCaseDemoMacOSSnapshotTests.swift
//  FBSnapshotTestCaseDemoMacOSTests
//
//  Created by Ivan Misuno on 12/03/2018.
//  Copyright © 2018 AlbumPrinter BV. All rights reserved.
//

import XCTest
@testable import FBSnapshotTestCaseDemoMacOS
import FBSnapshotTestCase

class FBSnapshotTestCaseDemoMacOSSnapshotTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func testExample() {
        let view = ViewWithText(frame: NSRect(x: 0, y: 0, width: 200, height: 100))
        FBSnapshotVerifyView(view)
    }

    func testExample_DrawHierarchy() {
        usesDrawViewHierarchyInRect = true
        let view = ViewWithText(frame: NSRect(x: 0, y: 0, width: 200, height: 100))
        FBSnapshotVerifyView(view)
    }

    func testLayer() {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        layer.backgroundColor = NSColor.green.cgColor

        let text = CATextLayer()
        text.string = "Lorem ipsum"
        text.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        text.backgroundColor = NSColor.clear.cgColor
        text.foregroundColor = NSColor.yellow.cgColor
        text.font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
        layer.addSublayer(text)

        let rectangle = CALayer()
        rectangle.frame = CGRect(x: 10, y: 60, width: 180, height: 30)
        rectangle.backgroundColor = NSColor.red.cgColor
        layer.addSublayer(rectangle)

        FBSnapshotVerifyLayer(layer)
    }

}
