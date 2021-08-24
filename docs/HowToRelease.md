= How to Release =
1. Update the CHANGELOG.md
2. Update iOSSnapshotTestCase.podspec version number
3. `pod spec lint` inside repo root
4. `pod install` inside FBSnapshotTestCaseDemo/
5. `pod trunk push iOSSnapshotTestCase.podspec`
6. `carthage build --no-skip-current --use-xcframeworks` inside `iOSSnapshotTestCaseCarthageDemo/`
7. Commit all the changes
8. Tag the commit in master with `git tag version-number`; e.g., `git tag 0.0.1`
9. Push the tag with `git push --tags`
10. `carthage build --archive --configuration Debug --use-xcframeworks`
11. Upload the `FBSnapshotTestCase.framework.zip` to the tagged release on Github for the version number
