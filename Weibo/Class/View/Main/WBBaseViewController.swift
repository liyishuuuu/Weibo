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
    lazy var navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 390, height: 80))
    lazy var navItem = UINavigationItem()
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
        view.backgroundColor = UIColor.gray
        
        /// 添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
    }
}
