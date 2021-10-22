platform :ios, '14.5'

use_frameworks!

target :'FBSnapshotTestCaseDemoTests' do
  pod 'iOSSnapshotTestCase', :path => '../..'
end

target :'FBSnapshotTestCasePreprocessorDemoTests' do
  pod 'iOSSnapshotTestCase', :path => '../..'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.4'
    end
  end
end
