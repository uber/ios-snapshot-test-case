Pod::Spec.new do |s|
  s.name         = "iOSSnapshotTestCase"
  s.module_name  = "FBSnapshotTestCase"
  s.version      = "2.2.0"
  s.summary      = "Snapshot view unit tests for iOS"
  s.description  = <<-DESC
                    A "snapshot test case" takes a configured UIView or CALayer
                    and uses the renderInContext: method to get an image snapshot
                    of its contents. It compares this snapshot to a "reference image"
                    stored in your source code repository and fails the test if the
                    two images don't match.
                   DESC
  s.homepage     = "https://github.com/uber/ios-snapshot-test-case"
  s.license      = 'MIT'
  s.author       = 'Uber'
  s.source       = { :git => "https://github.com/uber/ios-snapshot-test-case.git",
                     :tag => s.version.to_s }
  s.ios.deployment_target  = '8.1'
  s.tvos.deployment_target = '9.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true
  s.ios.frameworks   = 'XCTest','UIKit','Foundation','QuartzCore'
  s.tvos.frameworks   = 'XCTest','UIKit','Foundation','QuartzCore'
  s.osx.frameworks   = 'XCTest','AppKit','Foundation','QuartzCore'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.default_subspecs = 'SwiftSupport'
  s.swift_version = '4.0'
  s.subspec 'Core' do |cs|
    cs.source_files = 'FBSnapshotTestCase/**/*.{h,m}', 'FBSnapshotTestCase/*.{h,m}'
    cs.public_header_files = 'FBSnapshotTestCase/FBSnapshotTestCase.h','FBSnapshotTestCase/FBSnapshotTestCasePlatform.h','FBSnapshotTestCase/FBSnapshotTestController.h'
    cs.ios.private_header_files = 'FBSnapshotTestCase/Categories/UIImage+Compare.h','FBSnapshotTestCase/Categories/UIImage+Diff.h','FBSnapshotTestCase/Categories/UIImage+Snapshot.h'
    cs.tvos.private_header_files = 'FBSnapshotTestCase/Categories/UIImage+Compare.h','FBSnapshotTestCase/Categories/UIImage+Diff.h','FBSnapshotTestCase/Categories/UIImage+Snapshot.h'
    cs.osx.private_header_files = 'FBSnapshotTestCase/Categories-macOS/NSImage+Compare.h','FBSnapshotTestCase/Categories-macOS/NSImage+Diff.h','FBSnapshotTestCase/Categories-macOS/NSImage+Snapshot.h'
    cs.ios.exclude_files = 'FBSnapshotTestCase/Categories-macOS/*.{h,m}'
    cs.tvos.exclude_files = 'FBSnapshotTestCase/Categories-macOS/*.{h,m}'
    cs.osx.exclude_files = 'FBSnapshotTestCase/Categories/*.{h,m}'
  end
  s.subspec 'SwiftSupport' do |cs|
    cs.dependency 'iOSSnapshotTestCase/Core'
    cs.source_files = 'FBSnapshotTestCase/**/*.swift'
  end
end
