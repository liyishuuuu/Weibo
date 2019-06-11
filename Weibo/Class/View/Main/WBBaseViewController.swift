//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    /// 自定义导航条
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: self.view.frame.size.width, height: 64))
    
    /// 以后设置导航栏按钮使用 navItem
    lazy var navItem = UINavigationItem()

    // MARK - override

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    /// 重写title的didset
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}

// MARK: - 设置界面
extension WBBaseViewController {
    @objc func setUpUI() {
        /// 添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        if #available(iOS 11.0, *) {
            navigationBar.barTintColor = UIColor(named: "#F6F6F6")
        } else {
        }
        
        /// 设置navigationBar的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray,
                                             NSAttributedString.Key.font:UIFont.systemFont(ofSize:19)]
        navigationBar.tintColor=UIColor.darkGray
    }
}
