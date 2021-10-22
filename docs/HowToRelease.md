= How to Release =
1. Update the CHANGELOG.md
2. Update iOSSnapshotTestCase.podspec version number
3. `pod lib lint` inside repo root
4. `pod install` inside `demos/FBSnapshotTestCaseDemo/`
5. Commit all the changes
6. Tag the commit in master with `git tag version-number`; e.g., `git tag 0.0.1`
7. Push the tag with `git push --tags`
8. `pod trunk push iOSSnapshotTestCase.podspec`
9. `carthage update --use-xcframeworks` inside `demos/iOSSnapshotTestCaseCarthageDemo/`
10. `carthage build --no-skip-current --use-xcframeworks` inside `demos/iOSSnapshotTestCaseCarthageDemo/`
11. `iOSSnapshotTestCaseCarthageDemo/Cartfile.resolved` can be commited and pushed to repo without new version if changed.
11. Return to repo root.
11. `carthage build --archive --configuration Debug --use-xcframeworks`
12. Upload the `FBSnapshotTestCase.framework.zip` to the tagged release on Github for the version number
