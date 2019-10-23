//
//  AppDelegate.swift
//  iOSSnapshotTestCaseSPMDemo
//
//  Created by b.fernandes.santos on 23/10/19.
//  Copyright © 2019 Uber. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow()

    override init() {
        super.init()

        window?.frame = UIScreen.main.bounds
    }


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        guard let window = window else { return false }

        window.rootViewController = UIViewController()
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()

        return true
    }


}

