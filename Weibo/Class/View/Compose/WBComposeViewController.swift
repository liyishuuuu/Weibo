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

    /* -- CustomKeyboard --- */
    let keyboard = WBPasswordKeyboard(view, field: testField)
//    keyboard.keyboardStyle = .number
    keyboard.isEnableKeyboard = true
//    keyboard.whetherHighlight = true
    keyboard.frame.size.height = 300
//    keyboard.customDoneButton(title: "确定", titleColor: .white, theme: UIColor.blue, target: self, callback: nil)
    testField.becomeFirstResponder()
    }
}
