//
//  AppDelegate.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        sleep(2)
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

