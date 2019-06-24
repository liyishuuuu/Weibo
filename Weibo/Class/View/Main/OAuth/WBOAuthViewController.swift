//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/24.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 通过VewView来加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        
        // 设置导航栏
        title = "登录新浪微博"

        // 导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回", target: self, action: #selector(close), isBack: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

