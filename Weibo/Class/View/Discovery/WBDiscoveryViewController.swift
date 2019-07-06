//
//  WBDiscoveryViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBDiscoveryViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 模拟token过期
        WBNetWorkManager.shared.userAccount.access_token = nil
        // Do any additional setup after loading the view.
    }
}
