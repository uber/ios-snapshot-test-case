Pod::Spec.new do |s|
  s.name         = "iOSSnapshotTestCase"
  s.module_name  = "FBSnapshotTestCase"
  s.version      = "8.0.0"
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
  s.ios.deployment_target  = '10.0'
  s.tvos.deployment_target = '10.0'
  s.swift_version = '5.4'
  s.requires_arc = true
  s.frameworks   = 'XCTest','UIKit','Foundation','QuartzCore'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.default_subspecs = 'SwiftSupport'
  s.subspec 'Core' do |cs|
    cs.source_files = 'src/iOSSnapshotTestCaseCore/**/*.{h,m}', 'src/iOSSnapshotTestCaseCore/*.{h,m}'
    cs.public_header_files = 'src/iOSSnapshotTestCaseCore/Public/FBSnapshotTestCase.h','src/iOSSnapshotTestCaseCore/Public/FBSnapshotTestCasePlatform.h','src/iOSSnapshotTestCaseCore/Public/FBSnapshotTestController.h'
    cs.private_header_files = 'src/iOSSnapshotTestCaseCore/Categories/UIImage+Compare.h','src/iOSSnapshotTestCaseCore/Categories/UIImage+Diff.h','src/iOSSnapshotTestCaseCore/Categories/UIImage+Snapshot.h','src/iOSSnapshotTestCaseCore/Categories/UIApplication+KeyWindow.h'
  end
  s.subspec 'SwiftSupport' do |cs|
    cs.dependency 'iOSSnapshotTestCase/Core'
    cs.source_files = 'src/iOSSnapshotTestCase/SwiftSupport.swift'
  end
end
