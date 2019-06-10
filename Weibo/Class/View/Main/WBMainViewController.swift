//
//  WBMainViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/**
 WBMainViewController
 主视图控制器
 */
class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildControllers()
        setUpComposeButton()
    }

    // MARK - 监听方法
    // 撰写微博
    // TODO:
    // @objc 允许这个函数在‘运行时’ 通过OC的消息机制被调用
    @objc private func componseStatus() {
        print("撰写微博")
        
    }
    //懒加载一个button
    lazy var composeButton: UIButton = {
        let btn = UIButton()
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: .highlighted)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: .normal)
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: .highlighted)
        return btn
    }()
}

// MARK: - 设置界面
extension WBMainViewController {
    
    /// 设置撰写button
    private func setUpComposeButton() {
        
        /// 加载button
        tabBar.addSubview(composeButton)
        /// 设置button位置
        let count = CGFloat(children.count)
        // 计算每一个tab 的宽度，解决容错点的问题
        let w = tabBar.bounds.width/count - 1
        composeButton.frame = tabBar.bounds.insetBy(dx: 2 * w, dy: 0)
        
        /// 按钮监听方法
        composeButton.addTarget(self, action: #selector(componseStatus), for: .touchUpInside)
        
    }
    
    /// 设置5个tab键
    private func setUpChildControllers() {
        let array = [["clsName": "WBHomeViewController", "title": "首页", "imageName": "home"],
                     ["clsName": "WBDiscoveryViewController", "title": "发现", "imageName": "discover"],
                     ["clsName": "UIViewController"],
                     ["clsName": "WBMessageViewController", "title": "消息", "imageName": "message_center"],
                     ["clsName": "WBProfileViewController", "title": "我", "imageName": "profile"]]
        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    //// 使用字典创建一个子控制器
    private func controller(dict: [String: String]) -> UIViewController {
        
        /// 取得字典内容
        guard let clsName = dict["clsName"] else {
                  return UIViewController()
        }
        guard let title = dict["title"] else {
            return UIViewController()
        }
        guard let imageName = dict["imageName"] else {
            return UIViewController()
        }
        guard let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else {
            return UIViewController()
        }
        
        /// 创建视图控制器
        let vc = cls.init()
        /// 设置title
        vc.title = title
        /// 设置 图片
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_highlighted")
        ///实例化导航控制器的时候回调用push方法，将rootViewController压栈
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}

