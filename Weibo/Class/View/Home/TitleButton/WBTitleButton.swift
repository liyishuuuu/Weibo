//
//  WBTitleButton.swift
//  Weibo
//
//  Created by liyishu on 2019/7/6.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    // 重载构造函数
    // 如果title为nil 显示首页
    // 如果不为nil，显示title和箭头
    init(title: String?) {
        super.init(frame: CGRect())

        // 判断title是否是nil
        if title == nil {
            setTitle("首页", for: [])
        } else {
            setTitle(title!, for: [])

            // 设置图像
            setImage(UIImage(named: "navigationbar_arrow_up"), for: [])
            setImage(UIImage(named: "navigationbar_arrow_down"), for: .selected)
        }

        // 设置字体和颜色
        setTitleColor(UIColor.darkGray, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)

        // 设置大小
        sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
