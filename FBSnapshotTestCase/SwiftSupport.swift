/*
*  Copyright (c) 2015, Facebook, Inc.
*  All rights reserved.
*
*  This source code is licensed under the BSD-style license found in the
*  LICENSE file in the root directory of this source tree. An additional grant
*  of patent rights can be found in the PATENTS file in the same directory.
*
*/

#if os(OSX)
  public typealias View = NSView
#else
  public typealias View = UIView
#endif

#if swift(>=3)
  public extension FBSnapshotTestCase {
    public func FBSnapshotVerifyView(_ view: View, identifier: String = "", suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), tolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
      FBSnapshotVerifyViewOrLayer(view, identifier: identifier, suffixes: suffixes, tolerance: tolerance, file: file, line: line)
    }

    public func FBSnapshotVerifyLayer(_ layer: CALayer, identifier: String = "", suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), tolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
      FBSnapshotVerifyViewOrLayer(layer, identifier: identifier, suffixes: suffixes, tolerance: tolerance, file: file, line: line)
    }

    private func FBSnapshotVerifyViewOrLayer(_ viewOrLayer: AnyObject, identifier: String = "", suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), tolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
      let envReferenceImageDirectory = self.getReferenceImageDirectory(withDefault: FB_REFERENCE_IMAGE_DIR)
      var error: NSError?
      var comparisonSuccess = false

      if let envReferenceImageDirectory = envReferenceImageDirectory {
        for suffix in suffixes {
          let referenceImagesDirectory = "\(envReferenceImageDirectory)\(suffix)"
          if viewOrLayer.isKind(of: View.self) {
            do {
              try compareSnapshot(of: viewOrLayer as! View, referenceImagesDirectory: referenceImagesDirectory, identifier: identifier, tolerance: tolerance)
              comparisonSuccess = true
            } catch let error1 as NSError {
              error = error1
              comparisonSuccess = false
            }
          } else if viewOrLayer.isKind(of: CALayer.self) {
            do {
              try compareSnapshot(of: viewOrLayer as! CALayer, referenceImagesDirectory: referenceImagesDirectory, identifier: identifier, tolerance: tolerance)
              comparisonSuccess = true
            } catch let error1 as NSError {
              error = error1
              comparisonSuccess = false
            }
          } else {
            assertionFailure("Only \(View.self) and CALayer classes can be snapshotted")
          }

          assert(recordMode == false, message: "Test ran in record mode. Reference image is now saved. Disable record mode to perform an actual snapshot comparison!", file: file, line: line)

          if comparisonSuccess || recordMode {
            break
          }

          assert(comparisonSuccess, message: "Snapshot comparison failed: \(String(describing: error))", file: file, line: line)
        }
      } else {
        XCTFail("Missing value for referenceImagesDirectory - Set FB_REFERENCE_IMAGE_DIR as Environment variable in your scheme.")
      }
    }

    func assert(_ assertion: Bool, message: String, file: StaticString, line: UInt) {
      if !assertion {
        XCTFail(message, file: file, line: line)
      }
    }
  }
#else
public extension FBSnapshotTestCase {
  public func FBSnapshotVerifyView(view: View, identifier: String = "", suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), tolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    FBSnapshotVerifyViewOrLayer(view, identifier: identifier, suffixes: suffixes, tolerance: tolerance, file: file, line: line)
  }

  public func FBSnapshotVerifyLayer(layer: CALayer, identifier: String = "", suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), tolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    FBSnapshotVerifyViewOrLayer(layer, identifier: identifier, suffixes: suffixes, tolerance: tolerance, file: file, line: line)
  }

  private func FBSnapshotVerifyViewOrLayer(viewOrLayer: AnyObject, identifier: String = "", suffixes: NSOrderedSet = FBSnapshotTestCaseDefaultSuffixes(), tolerance: CGFloat = 0, file: StaticString = #file, line: UInt = #line) {
    let envReferenceImageDirectory = self.getReferenceImageDirectoryWithDefault(FB_REFERENCE_IMAGE_DIR)
    var error: NSError?
    var comparisonSuccess = false

    if let envReferenceImageDirectory = envReferenceImageDirectory {
      for suffix in suffixes {
        let referenceImagesDirectory = "\(envReferenceImageDirectory)\(suffix)"
        if viewOrLayer.isKindOfClass(View) {
          do {
            try compareSnapshotOfView(viewOrLayer as! View, referenceImagesDirectory: referenceImagesDirectory, identifier: identifier, tolerance: tolerance)
            comparisonSuccess = true
          } catch let error1 as NSError {
            error = error1
            comparisonSuccess = false
          }
        } else if viewOrLayer.isKindOfClass(CALayer) {
          do {
            try compareSnapshotOfLayer(viewOrLayer as! CALayer, referenceImagesDirectory: referenceImagesDirectory, identifier: identifier, tolerance: tolerance)
            comparisonSuccess = true
          } catch let error1 as NSError {
            error = error1
            comparisonSuccess = false
          }
        } else {
          assertionFailure("Only \(View.self) and CALayer classes can be snapshotted")
        }

        assert(recordMode == false, message: "Test ran in record mode. Reference image is now saved. Disable record mode to perform an actual snapshot comparison!", file: file, line: line)

        if comparisonSuccess || recordMode {
          break
        }

        assert(comparisonSuccess, message: "Snapshot comparison failed: \(error)", file: file, line: line)
      }
    } else {
      XCTFail("Missing value for referenceImagesDirectory - Set FB_REFERENCE_IMAGE_DIR as Environment variable in your scheme.")
    }
  }

  func assert(assertion: Bool, message: String, file: StaticString, line: UInt) {
    if !assertion {
      XCTFail(message, file: file, line: line)
    }
  }
}
#endif
