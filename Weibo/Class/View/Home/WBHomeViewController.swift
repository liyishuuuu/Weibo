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
        
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00tV15KGehU_9B87cffd41cdGhkzoB"]
        
//        WBNetWorkManager.shared.get(urlString, parameters: params, progress: nil, success: { (_, json) in
//            print(json)
//        }) { (_, error) in
//            print("网络请求失败\(error)")
//        }
        
        WBNetWorkManager.shared.request(URLSting: urlString, parameters: params) { (json, isSuccess) in
            print(json)
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
