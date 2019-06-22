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
            self.tableView?.reloadData()
        }
    }
}

// MARK: - 具体的数据源方法实现，override 重写父类方法，不需要super，在基类中已经实现
extension WBHomeViewController {

    /// 设置cell的个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    /// 填充数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// 注册原型cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        /// 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        /// 设置cell
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        /// 返回cell
        return cell
    }
}

// MARK: - 设置界面
extension WBHomeViewController {
    /// 重写父类的方法
    override func setUpUI() {
        super.setUpUI()
    }
}
