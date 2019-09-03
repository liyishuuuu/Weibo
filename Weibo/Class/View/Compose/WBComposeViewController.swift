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
    let keyboard = MDPLPasswordKeyboard(view, field: testField)
    keyboard.isEnableKeyboard = true
//    keyboard.frame.size.height = 220
    testField.becomeFirstResponder()
    }
}
