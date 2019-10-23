//
//  iOSSnapshotTestCaseSPMDemoTests.swift
//  iOSSnapshotTestCaseSPMDemoTests
//
//  Created by b.fernandes.santos on 23/10/19.
//  Copyright © 2019 Uber. All rights reserved.
//

import XCTest
import FBSnapshotTestCase

class iOSSnapshotTestCaseSPMDemoTests: FBSnapshotTestCase {

    override func setUp() {
        super.setUp()
        recordMode = false
    }

    func testExample() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        view.backgroundColor = UIColor.blue
        FBSnapshotVerifyView(view)
        FBSnapshotVerifyLayer(view.layer)
    }

}
