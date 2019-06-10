//
//  WBNavigationController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 隐藏默认的NavigationBar
        navigationBar.isHidden = true
    }
    
    /// 重写push方法
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        print(viewController)
        
        if children.count > 0 {
            /// 隐藏底部的 TabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
}
