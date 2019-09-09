//
//  WBComposeViewController.swift
//  Weibo
//
//  Created by liyishu on 2019/9/1.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBComposeViewController: UIViewController {

    @IBOutlet weak var testField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.test()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", target: self, action: #selector(close))
    }

    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func test() {
        _ = WBPasswordKeyboard(view, field: testField, withDelPicture: true)
        let vi = WBPasswordView(frame: CGRect(x: (view.bounds.width - 300) / 2,
                                              y:250,
                                              width: 300,
                                              height: 50))
        view.addSubview(vi)
    }
}
