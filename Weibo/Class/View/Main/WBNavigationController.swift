//
//  WBNavigationController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBNavigationController: UINavigationController {
    
    // MRAK - override

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
            if let vc = viewController as? WBBaseViewController {
                
                var title: String = "返回"
                /// 判断控制器的级数
                if children.count == 1 {
                    title = children.first?.title ?? "返回"
                }
                /// 取出自定义的navItem
                vc.navItem.leftBarButtonItem = UIBarButtonItem(title: title, target: self, action: #selector(popTpParent))
            }
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// 返回上一级
    @objc private func popTpParent() {
        popViewController(animated: true)
    }
}
