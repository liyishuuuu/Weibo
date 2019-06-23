//
//  WBBlogViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
/// 定义全局常量，使用private修饰
private let cellId1 = "cellId1"
class WBBlogViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 实例化ViewModel
    private lazy var listViewModel = WBStatusListModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        listViewModel.loadStatus { (isSuccess) in
            /// 结束下拉刷新
            super.viewDidLoad()
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.reloadData()
        }
//        tableView.reloadData()
    }

    /// 设置cell的个数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    /// 填充数据源
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        /// 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "blogCellId", for: indexPath)
        /// 设置cell
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        /// 返回cell
        return cell
    }
}
