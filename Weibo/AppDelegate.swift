//
//  AppDelegate.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD
import AFNetworking

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // 设置应用程序额外设置
        self.setupAddtions()
        sleep(2)
        window = UIWindow()
        window?.backgroundColor = UIColor.white
        window?.rootViewController = WBMainViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
   
    private func setupAddtions() {

        // 设置解除SVProgressHUD的s最小时间
        SVProgressHUD.setMinimumDismissTimeInterval(1)

        // 设置网络加载指示器
        AFNetworkActivityIndicatorManager.shared().isEnabled = true
        }
}

