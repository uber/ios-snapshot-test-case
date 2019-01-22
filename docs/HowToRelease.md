= How to Release =
1. Update the CHANGELOG.md
2. Update iOSSnapshotTestCase.podspec
3. Tag the commit in master with `git tag version-number`; e.g., `git tag 0.0.1`
4. Push the tag with `git push --tags`
5. `pod trunk push iOSSnapshotTestCase.podspec`
6. `carthage build --archive --configuration Debug`
7. Upload the `FBSnapshotTestCase.framework.zip` to the tagged release on Github for the version number
