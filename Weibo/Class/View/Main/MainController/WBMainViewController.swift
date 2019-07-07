//
//  WBMainViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

/**
 WBMainViewController
 主视图控制器
 */
class WBMainViewController: UITabBarController {

    // 定时器
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChildControllers()
        setUpComposeButton()
        
        // 设置新特性视图
        setupNewFeatureViews()

        // 注册通知
        NotificationCenter.default.addObserver(self, selector: #selector(userLogin), name: NSNotification.Name(rawValue: WBUsershouldLoginNotification), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK - 监听方法
    // 撰写微博
    // TODO:
    // @objc 允许这个函数在‘运行时’ 通过OC的消息机制被调用
    @objc private func userLogin(n: Notification) {
        print("用户登录通知\(n)")
        if n.object != nil {
            SVProgressHUD.showInfo(withStatus: "登录超时，请重新登录")
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            // 展现登录控制器
            let vc = UINavigationController(rootViewController: WBOAuthViewController())
            self.present(vc, animated: true, completion: nil)
        }
    }
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
        
        // 从bundle加载配置的json
        /// 1,路径 2.加载NSData 3.反序列化转换成数组
        guard let path = Bundle.main.path(forResource: "main.json", ofType: nil),
              let data = NSData(contentsOfFile: path),
              let array = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [[String: Any]]
            else {
            return
        }

        // 遍历数组循环创建控制器数组
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

// MARK: - 新特性视图处理
extension WBMainViewController {

    // 设置新特性视图
    func setupNewFeatureViews() {

        // 0.判断是否登录
        if !WBNetWorkManager.shared.userlogon {
            return
        }

        // 1.如果更新，显示新特性, 否则显示欢迎
        let v = isNewFeature ? WBNewFeatureView() : WBWelcomeView.welcomeView()

        // 2.添加视图
        view.addSubview(v)
    }

    /// extention 可以有计算型属性，不会占存储空间
    /// 构造函数，给属性分配空间
    private var isNewFeature: Bool {
        // 1. 取当前版本号
        print(Bundle.main.infoDictionary ?? "")
        let currentVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""

        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path: String = (docDir as? NSString)?.appendingPathComponent("path.json") ?? ""
        let sandBoxVersion = try? (String(contentsOfFile: path))
        
        // 2.将当前版本号保存在沙盒中
        try? currentVersion.write(toFile: path, atomically: true, encoding: .utf8)

        // 3. 返回两个版本号，是否一致
        return currentVersion != sandBoxVersion
    }
}
