//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK: - 设置界面
extension WBBaseViewController {
    @objc func setUpUI() {
        view.backgroundColor = UIColor.gray
    }
}
