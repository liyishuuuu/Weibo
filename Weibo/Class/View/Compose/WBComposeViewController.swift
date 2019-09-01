//
//  WBComposeViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/9/1.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBComposeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target: self, action: #selector(close))
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
