//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 定义全局常量，使用private修饰
private let cellId = "cellId"
class WBHomeViewController: WBBaseViewController {

    // 实例化ViewModel
    private lazy var listViewModel = WBStatusListModel()
    /// 加载数据
    override func loadData() {
        listViewModel.loadStatus { (isSuccess) in
            /// 结束下拉刷新
            self.refreshControl?.endRefreshing()
            self.isPullup = false
            self.setupTableView()
            self.tableView?.reloadData()
        }
    }
}

// MARK: - 具体的数据源方法实现，override 重写父类方法，不需要super，在基类中已经实现
extension WBHomeViewController {

    /// 设置cell的个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listViewModel.statusList.count
    }
    
    /// 填充数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// 注册原型cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        /// 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        /// 设置cell
        cell.textLabel?.text = self.listViewModel.statusList[indexPath.row].text
        /// 返回cell
        return cell
    }
}

// MARK: - 设置界面
extension WBHomeViewController {
    /// 重写父类的方法
    override func setUpUI() {
        super.setUpUI()
        view.addSubview(navigationBar)
        navItem.leftBarButtonItem = UIBarButtonItem(title: "微博", target: self, action: #selector(showBlog))
    }
    @objc private func showBlog() {
        print(#function)
        let vc = WBBlogViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }

    private func setupTableView() {
        let tableView: UITableView = UITableView(frame: view.bounds, style: .plain)
        ///  设置atableView在navigation的下面
        view.insertSubview(tableView, belowSubview: navigationBar)
        tableView.dataSource = self
        tableView.delegate = self
        
        // 设置内容缩进
        tableView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        
        // 设置刷新控件
        /// 1.实例化控件
        self.refreshControl = UIRefreshControl()
        
        /// 1.添加到表格视图
        tableView.addSubview(refreshControl!)
        
        /// 1.添加监听方法
        refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
}
