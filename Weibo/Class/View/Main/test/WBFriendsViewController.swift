//
//  WBFriendsViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBFriendsViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc private func showNext() {
        let vc = WBFriendsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension WBFriendsViewController {

    /// 重写父类的方法
    override func setUpUI() {
        super.setUpUI()
        /// 自定义rightBarButton
        navItem.rightBarButtonItem = UIBarButtonItem(title: "下一个", target: self, action: #selector(showNext))
    }
}
