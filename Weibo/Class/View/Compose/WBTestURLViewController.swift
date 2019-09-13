//
//  WBTestViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/9/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBTestURLViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test()
    }

    private func test() {
        // 取出链接，及文本描述
        let string: String = "<a href=\"https://weibo.com/u/5650359081\" rel=\"nofollow\">微博 weibo.com</a>"
        let URLString = string.href()
        print(URLString)
    }
}
