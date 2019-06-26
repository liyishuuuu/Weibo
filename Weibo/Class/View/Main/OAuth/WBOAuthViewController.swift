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
        
        // 加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectUri)"
        // 建立要访问的url资源
        guard let url = URL(string: urlString) else {
            return
        }
        // 建立请求
        let request = URLRequest(url: url)
        // 加载请求
        webView.loadRequest(request)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}

