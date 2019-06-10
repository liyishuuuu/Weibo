//
//  UIButton+Extension.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    
    /// 创建 UIBarButtonItem
    ///
    /// - Parameters:
    ///   - title: title
    ///   - target: target
    ///   - action: action
    convenience init(title: String, target: AnyObject?, action: Selector) {
        let btn: UIButton = UIButton()
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.orange, for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        
        /// self.init 实例化UIButtonItem
        self.init(customView: btn)
    }
}
