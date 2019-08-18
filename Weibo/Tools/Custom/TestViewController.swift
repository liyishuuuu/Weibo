//
//  ViewController.swift
//  TestViewController
//
//  Created by liyishu on 2018/2/8.
//  Copyright © 2018年 Apple. All rights reserved.
//
import UIKit

class TestViewController: UIViewController {

    let testBtn = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        testBtn.frame = CGRect(x: 15, y: 30, width: 300, height: 44)
        testBtn.backgroundColor = UIColor.blue
        testBtn.setTitle("test", for: .normal)
        testBtn.addTarget(self, action: #selector(test), for: .touchUpInside)
        self.view.addSubview(testBtn)
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @objc private func test() {
        let vc = WBSwiftUIViewController()
        self.present(vc, animated:true, completion:nil)
    }
}
