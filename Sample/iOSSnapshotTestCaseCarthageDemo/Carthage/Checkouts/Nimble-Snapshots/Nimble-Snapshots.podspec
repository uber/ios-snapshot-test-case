Pod::Spec.new do |s|
  s.name         = "Nimble-Snapshots"
  s.version      = "8.0.0"
  s.summary      = "Nimble matchers for iOSSnapshotTestCase"
  s.description  = <<-DESC
                   Nimble matchers for iOSSnapshotTestCase. Highly derivative of [Expecta Matchers for iOSSnapshotTestCase](https://github.com/dblock/ios-snapshot-test-case-expecta).
                   DESC
  s.homepage     = "https://github.com/ashfurrow/Nimble-Snapshots"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Ash Furrow" => "ash@ashfurrow.com" }
  s.social_media_url   = "http://twitter.com/ashfurrow"
  s.ios.deployment_target = "10.0"
  s.tvos.deployment_target = "9.0"
  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO' }
  s.source       = { :git => "https://github.com/ashfurrow/Nimble-Snapshots.git", :tag => s.version }
  s.default_subspec = "Core"
  s.frameworks  = "Foundation", "XCTest", "UIKit"

  s.subspec "Core" do |ss|
    ss.source_files  = "Nimble_Snapshots/*.{h,m,swift}",
                        "Nimble_Snapshots/DynamicType/*.{swift,m,h}",
                        "Nimble_Snapshots/DynamicSize/*.{swift}"
    ss.dependency "iOSSnapshotTestCase", "~> 6.0"
    ss.dependency "Nimble", "~> 8.0"
  end

  # for compatibiliy reasons
  s.subspec "DynamicType" do |ss|
    ss.dependency "Nimble-Snapshots/Core"
  end

  s.subspec "DynamicSize" do |ss|
    ss.dependency "Nimble-Snapshots/Core"
  end
end
