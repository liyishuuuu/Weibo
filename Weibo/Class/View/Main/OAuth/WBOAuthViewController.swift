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
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "返回",
                                                           target: self,
                                                           action: #selector(close),
                                                           isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "自动填充",
                                                            target: self,
                                                            action: #selector(autoFill))
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
    
    ///MARK: private method

    /// 关闭画面
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
    
    // 自动填充 webView注入，直接通过js修改‘本地浏览器’缓存的页面内容
    // 点击登录按钮, 执行submitsubmit()， 将本地数据提交到服务器
    @objc private func autoFill() {
        
        // 准备js
        let js = "document.getElementById('userId').value = '18273791262';" +
        "document.getElementById('passwd').value = 'lys735412408';"
        
        // 让webView执行js
        webView.stringByEvaluatingJavaScript(from: js)
    }
}

