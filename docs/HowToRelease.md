= How to Release =
1. Update the CHANGELOG.md
2. Tag the commit in master with `git tag version-number`; e.g., `git tag 0.0.1`
3. Push the tag with `git push --tags`
4. `pod trunk push iOSSnapshotTestCase.podspec`
5. `carthage build --archive --configuration Debug`
2. Upload the `FBSnapshotTestCase.framework.zip` to the tagged release on Github for the version number
