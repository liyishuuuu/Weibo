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
        let array: [[String: Any]] = [["clsName": "WBHomeViewController",
                                       "title": "首页",
                                       "imageName": "home",
                                       "visitorInfo": ["imageName": "", "message": "关注一些人，回这里看看"]],
                                       ["clsName": "WBDiscoveryViewController",
                                        "title": "发现",
                                        "imageName": "discover",
                                        "visitorInfo": ["imageName": "visitordiscover_image_message",
                                                        "message": "登陆后，别人发给你的消息将在这里展示"]],
                                       ["clsName": "UIViewController"],
                                       ["clsName": "WBMessageViewController",
                                        "title": "消息",
                                        "imageName": "message_center",
                                        "visitorInfo": ["imageName": "visitordiscover_image_message",
                                                        "message": "登陆后，最新最热微博尽在掌握"]],
                                       ["clsName": "WBProfileViewController",
                                        "title": "我",
                                        "imageName": "profile",
                                        "visitorInfo": ["imageName": "visitordiscover_image_profile",
                                                        "message": "登陆后，你的信息将在这里展示"]]]
        /// 测试数据格式是否正确
        (array as NSArray).write(toFile: "/Users/liyishu/Desktop/files/Demo.plist", atomically: true)

        var arrayM = [UIViewController]()
        for dict in array {
            arrayM.append(controller(dict: dict))
        }
        viewControllers = arrayM
    }
    
    //// 使用字典创建一个子控制器
    ///
    /// - Parameter dict: 信息字典[clsName,title,imageName,visitorInfo] 
    /// - Returns: UIViewController
    private func controller(dict: [String: Any]) -> UIViewController {
        
        /// 取得字典内容
        guard let clsName = dict["clsName"] as? String else {
                  return UIViewController()
        }
        guard let title = dict["title"] as? String else {
            return UIViewController()
        }
        guard let imageName = dict["imageName"] as? String else {
            return UIViewController()
        }
        guard let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? WBBaseViewController.Type else {
            return UIViewController()
        }
        guard let visitorDict = dict["visitorInfo"] as? [String: String] else {
            return UIViewController()
        }
        /// 创建视图控制器
        let vc = cls.init()
        /// 设置title
        vc.title = title
        ///设置控制器的访客信息字典
        vc.visitorInfoDict = visitorDict
        /// 设置 图片
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_highlighted")
        ///实例化导航控制器的时候回调用push方法，将rootViewController压栈
        let nav = WBNavigationController(rootViewController: vc)
        return nav
    }
}

