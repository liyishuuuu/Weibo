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

    /// 微博数据数组
    private lazy var statusList = [String]()
    /// 加载数据
    override func loadData() {
        
        // 用工具加载数据
        WBNetWorkManager.shared.statusList { (list, isSuccess) in
            
            // 字典转模型 绑定数据
            print(list)
            print("加载数据结束")
        }
        print("开始加载数据")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            for i in 0..<10 {
                
                /// 将数据插入到数组的顶部
                self.statusList.insert(i.description, at: 0)
            }
        }
        print("刷新表格")
        /// 结束下拉刷新
        refreshControl?.endRefreshing()
        tableView?.reloadData()
    }
}

// MARK: - 具体的数据源方法实现，override 重写父类方法，不需要super，在基类中已经实现
extension WBHomeViewController {

    /// 设置cell的个数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    
    /// 填充数据源
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /// 注册原型cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        /// 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        /// 设置cell
        cell.textLabel?.text = statusList[indexPath.row]
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
