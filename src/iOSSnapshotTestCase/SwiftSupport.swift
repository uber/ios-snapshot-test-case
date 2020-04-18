/*
 *  Copyright (c) 2017-2018, Uber Technologies, Inc.
 *  Copyright (c) 2015-2018, Facebook, Inc.
 *
 *  This source code is licensed under the MIT license found in the
 *  LICENSE file in the root directory of this source tree.
 *
 */

import UIKit
import XCTest

#if SWIFT_PACKAGE
@_exported import iOSSnapshotTestCaseCore
#endif

public extension FBSnapshotTestCase {
    func FBSnapshotVerifyView(_ view: UIView, identifier: String? = nil, suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    FBSnapshotVerifyViewOrLayer(view, identifier: identifier, suffixes: suffixes, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance, file: file, line: line)
  }

    func FBSnapshotVerifyViewController(_ viewController: UIViewController, identifier: String? = nil, suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    viewController.view.bounds = UIScreen.main.bounds
    viewController.viewWillAppear(false)
    viewController.viewDidAppear(false)

    FBSnapshotVerifyView(viewController.view, identifier: identifier, suffixes: suffixes, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance, file: file, line: line)
  }

    func FBSnapshotVerifyLayer(_ layer: CALayer, identifier: String? = nil, suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    FBSnapshotVerifyViewOrLayer(layer, identifier: identifier, suffixes: suffixes, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance, file: file, line: line)
  }

    func FBSnapshotVerifyViewForLightDarkMode(_ view: UIView, identifier: String? = nil, delay: TimeInterval = 0, perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
      let viewController = UIViewController()
      viewController.view.addSubview(view)

      FBSnapshotVerifyViewControllerForLightDarkMode(viewController, identifier: identifier, delay: delay, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance, file: file, line: line)
    }

    func FBSnapshotVerifyViewControllerForLightDarkMode(_ viewController: UIViewController, identifier: String? = nil, delay: TimeInterval = 0, perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
      if #available(iOS 13.0, *) {
        let navigationController = UINavigationController(rootViewController: viewController)
        let window = UIWindow()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        // Take snapshot in light mode
        navigationController.overrideUserInterfaceStyle = .light
        RunLoop.main.run(until: Date(timeIntervalSinceNow: delay))

        let lightId = [identifier, "light"].compactMap { $0 }.joined(separator: "_")
        FBSnapshotVerifyView(navigationController.view, identifier: lightId, suffixes: ["Light"], perPixelTolerance: 0, overallTolerance: 0, file: file, line: line)

        // Take snapshot in dark mode
        window.rootViewController = nil
        window.rootViewController = navigationController
        navigationController.overrideUserInterfaceStyle = .dark
        RunLoop.main.run(until: Date(timeIntervalSinceNow: delay))

        let darkId = [identifier, "dark"].compactMap { $0 }.joined(separator: "_")
        FBSnapshotVerifyView(navigationController.view, identifier: darkId, suffixes: ["Dark"], perPixelTolerance: 0, overallTolerance: 0, file: file, line: line)

        window.rootViewController = nil
      }
    }

  private func FBSnapshotVerifyViewOrLayer(_ viewOrLayer: AnyObject, identifier: String? = nil, suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), perPixelTolerance: CGFloat = 0, overallTolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    let envReferenceImageDirectory = self.getReferenceImageDirectory(withDefault: nil)
    let envImageDiffDirectory = self.getImageDiffDirectory(withDefault: nil)
    var error: NSError?
    var comparisonSuccess = false

    for suffix in suffixes {
      let referenceImagesDirectory = "\(envReferenceImageDirectory)\(suffix)"
      let imageDiffDirectory = envImageDiffDirectory
      if viewOrLayer.isKind(of: UIView.self) {
        do {
          try compareSnapshot(of: viewOrLayer as! UIView, referenceImagesDirectory: referenceImagesDirectory, imageDiffDirectory: imageDiffDirectory, identifier: identifier, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance)
          comparisonSuccess = true
        } catch let error1 as NSError {
          error = error1
          comparisonSuccess = false
        }
      } else if viewOrLayer.isKind(of: CALayer.self) {
        do {
          try compareSnapshot(of: viewOrLayer as! CALayer, referenceImagesDirectory: referenceImagesDirectory, imageDiffDirectory: imageDiffDirectory, identifier: identifier, perPixelTolerance: perPixelTolerance, overallTolerance: overallTolerance)
          comparisonSuccess = true
        } catch let error1 as NSError {
          error = error1
          comparisonSuccess = false
        }
      } else {
        assertionFailure("Only UIView and CALayer classes can be snapshotted")
      }

      assert(recordMode == false, message: "Test ran in record mode. Reference image is now saved. Disable record mode to perform an actual snapshot comparison!", file: file, line: line)

      if comparisonSuccess || recordMode {
        break
      }

      assert(comparisonSuccess, message: "Snapshot comparison failed: \(String(describing: error))", file: file, line: line)
    }
  }

  func assert(_ assertion: Bool, message: String, file: StaticString, line: UInt) {
    if !assertion {
      XCTFail(message, file: file, line: line)
    }
  }
}
