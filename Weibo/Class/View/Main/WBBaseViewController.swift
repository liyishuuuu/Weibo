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
    /// 定义tableView
    var tableView: UITableView?
    /// 以后设置导航栏按钮使用 navItem
    lazy var navItem = UINavigationItem()

    // MARK - override

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    @objc private func register() {
        print(#function)
        print("注册")
    }
    @objc private func login() {
        print(#function)
        print("登录")
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
       self.setupNavigation()
        self.setupTableView()
    }
    
    /// 设置tableView
    private func setupTableView() {
        let tableView: UITableView = UITableView(frame: view.bounds, style: .plain)
        view.insertSubview(tableView, belowSubview: navigationBar)
    }
    /// 设置导航条
    private func setupNavigation() {
        /// 添加导航条
        view.addSubview(navigationBar)
        navigationBar.items = [navItem]
        /// 设置navigationBar的字体颜色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray,
                                             NSAttributedString.Key.font:UIFont.systemFont(ofSize:19)]
        navigationBar.tintColor = UIColor.orange
        navigationBar.barTintColor = UIColor.white
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return
//    }
    
}
