//
//  WBBlogViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/22.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBBlogViewController: UIViewController {
    
    // 实例化ViewModel
    private lazy var listViewModel = WBStatusListModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
    }
}
