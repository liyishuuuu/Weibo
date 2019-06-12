//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @objc private func showFriends() {
        print(#function)
        let vc = WBFriendsViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 设置界面
extension WBHomeViewController {
    /// 重写父类的方法
    override func setUpUI() {
        super.setUpUI()
    }
}
