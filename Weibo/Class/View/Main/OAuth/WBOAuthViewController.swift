//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/24.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import SVProgressHUD

/// 通过VewView来加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    // MARK: - 变量

    private lazy var webView = UIWebView()

    // MARK: - override method

    override func loadView() {
        view = webView
        
        // webView 代理
        webView.delegate = self

        // 设置背景颜色
        view.backgroundColor = UIColor.white

        //  取消滚动视图
        webView.scrollView.isScrollEnabled = false

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

extension WBOAuthViewController: UIWebViewDelegate {

    /// webView 将要加载
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: 将要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: 是否加载request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        
        // 如果请求地址包含 https://baidu.com不加载页面，否则加载页面
        if request.url?.absoluteString.hasPrefix(WBRedirectUri) == false {
            return true
        }
        print("加载请求----\(String(describing: request.url?.absoluteString))")
        print("加载请求----\(String(describing: request.url?.query))")
        
        //从query中获取 授权码
        let code = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        print("获取授权码----\(String(describing: code))")
        
        // 使用授权码获取AccessToken
        WBNetWorkManager.shared.loadAccessToken(code: code) { (isSuccess) in
            if !isSuccess {
                SVProgressHUD.showInfo(withStatus: "网络请求失败")
            } else {
                SVProgressHUD.showInfo(withStatus: "网络请求成功")
                
                // 发送通知
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserLoginSucceedNotification),                                  object: nil)
                self.close()
                SVProgressHUD.dismiss()
            }
        }
        return true
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}

