//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
///
///
/// 注意: extension 中不能有属性
///      extension 中不能重写父类方法,是子类的职责，扩展时对类的拓展
///
class WBBaseViewController: UIViewController {

    // MARK - 变量

    /// 自定义导航条
    lazy var navigationBar = SecondNavigationBar(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: self.view.frame.size.width,
                                                               height: 64))
    
    /// 定义tableView, 如果用户没有登录就不创建
    var tableView: UITableView?
    /// 自定义导航条目，以后设置导航栏按钮使用 navItem
    lazy var navItem = UINavigationItem()

    // MARK - override

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.loadData()
    }

    /// 重写title的didset
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
    func loadData() {
        tableView?.delegate = self
        tableView?.dataSource = self
    }
}

// MARK: - 设置界面
extension WBBaseViewController {
    @objc func setUpUI() {
        /// 取消自动缩进m，如果隐藏了导航栏，会自动缩进20点
        automaticallyAdjustsScrollViewInsets = false
        self.setupNavigation()
        self.setupTableView()
    }
    
    /// 设置tableView
    private func setupTableView() {
        let tableView: UITableView = UITableView(frame: view.bounds, style: .plain)
        ///  设置atableView在navigation的下面 
        view.insertSubview(tableView, belowSubview: navigationBar)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
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
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension WBBaseViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //基类只是准备方法，自雷负责具体的实现
    // 子类的数据源不需要 super
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 只是保证没有语法错误
        return UITableViewCell()
    }
}

// MARK: - 监听方法
extension WBHomeViewController {
    @objc private func register() {
        print(#function)
        print("注册")
    }
    @objc private func login() {
        print(#function)
        print("登录")
    }
}

/// 解决NavigationBar高度问题
class SecondNavigationBar: UINavigationBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            let stringFromClass = NSStringFromClass(subview.classForCoder)
            print("--------- \(stringFromClass)")
            if stringFromClass.contains("BarBackground") {
                subview.frame = self.bounds
            } else if stringFromClass.contains("UINavigationBarContentView") {
                subview.frame = CGRect(x: 0, y: 20, width: UIScreen.main.bounds.size.width, height: 44)
            }
        }
    }
}
