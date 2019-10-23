//
//  AppDelegate.swift
//  Bootstrap
//
//  Created by Ash Furrow on 2014-08-07.
//  Copyright (c) 2014 Artsy. All rights reserved.
//

import UIKit

#if swift(>=4.2)
    typealias UIApplicationLaunchOptionsKey = UIApplication.LaunchOptionsKey
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        // There are device specific tests, so we need to be tight on the devices running tests

        let version = ProcessInfo.processInfo.operatingSystemVersion
        let minVersion = OperatingSystemVersion(majorVersion: 10, minorVersion: 3, patchVersion: 0)
        assert(ProcessInfo.processInfo.isOperatingSystemAtLeast(minVersion),
               "The tests should be run at least on iOS 10.0, not \(version.majorVersion), \(version.minorVersion)")

        #if swift(>=4.2)
        let stringFromSize: (CGSize) -> String = { NSCoder.string(for: $0) }
        #else
        let stringFromSize: (CGSize) -> String = { NSStringFromCGSize($0) }
        #endif
        let nativeResolution = UIScreen.main.nativeBounds.size
        assert(isExpectedDevice(nativeResolution: nativeResolution),
               "The tests should be run on an iPhone 8, not a device with " +
               "native resolution \(stringFromSize(nativeResolution))")

        return true
    }

    func isExpectedDevice(nativeResolution: CGSize) -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone &&
            nativeResolution == CGSize(width: 750, height: 1334)
    }
}
