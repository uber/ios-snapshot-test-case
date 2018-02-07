# Library vs Application Test Bundles

* Authors: [Alan Zeino](https://github.com/alanzeino)

## Introduction

Developers writing unit tests for iOS using XCTest typically use Application Test Bundles without much consideration as to _why_ their tests need to be inside an Application Test Bundle, as opposed to a Library Test Bundle. This document describes what you can and can't do with both, and why you might want to use a Library Test Bundle.

Library Test Bundles were once called _Logic_ Test Bundles in Apple's nomenclature. In the context of this document, both Library and Logic are interchangeable.

### Application tests

Unit tests that test parts of an application (such as UIViewControllers, UIWindows, UIViews) should typically be part of an Application test bundle. An Application test bundle requires a Test Host and at test run time, a Simulator too.

There are some APIs that only work inside Application test bundles. In our testing, we've seen a few. Here are some:

* `-[UIControl sendActionsForControlEvents:]` — This API is commonly used to trigger actions at runtime and sometimes you might want to use it inside a test to trigger a particular code path which is ordinarily run when a user performs an action. While it does not work inside a Library test bundle, [we've written our own version for unit tests](FBSnapshotTestCase/Categories/UIControl+SendActions.h) that works well for this need. If you decide to use that category, make sure it can only be seen inside unit tests and not all of your code.
* `UIAppearance` — Most `UIAppearance` APIs break when there is no test host present.
* `UIWindow` — You cannot make a `UIWindow` you created during your test the 'key window' because `makeKeyAndVisible` crashes at test run time. One workaround is to instead set `hidden` to `false` on the `UIWindow` instance you created. However there still won't be a 'key window' so if you have code that adds a `UIView` as a subview of the `keyWindow` then that will break.

### Library tests
Unit tests that test parts of a framework or libary should be part of a Library test bundle. This does not require a Test Host or a Simulator (though in Xcode 9, Apple still launches a Simulator for these tests).