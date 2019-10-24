Pod::Spec.new do |s|
  s.name         = "iOSSnapshotTestCase"
  s.module_name  = "FBSnapshotTestCase"
  s.version      = "6.2.1"
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
  s.swift_version = '5.1'
  s.requires_arc = true
  s.frameworks   = 'XCTest','UIKit','Foundation','QuartzCore'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.user_target_xcconfig = { 'FRAMEWORK_SEARCH_PATHS' => '$(PLATFORM_DIR)/Developer/Library/Frameworks' }
  s.default_subspecs = 'SwiftSupport'
  s.subspec 'Core' do |core|
    core.source_files = 'FBSnapshotTestCase/Core/**/*.{h,m}', 'FBSnapshotTestCase/Core/**/*.{h,m}'
    core.public_header_files = 'FBSnapshotTestCase/Core/Snapshot/*.h'
    core.private_header_files = 'FBSnapshotTestCase/Core/UIImage+Compare.h','FBSnapshotTestCase/Core/UIImage+Diff.h','FBSnapshotTestCase/Core/UIImage+Snapshot.h'
  end
  s.subspec 'SwiftSupport' do |support|
    support.source_files = 'FBSnapshotTestCase/Core-Support/**/*.swift'
    support.dependency 'iOSSnapshotTestCase/Core'
  end
end
