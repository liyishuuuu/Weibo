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
            setTitle(title! + " ", for: [])

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

    // 重新布局子视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,
            let imageView = imageView else {
            return
        }

        // 将titleLabel的 x 向左移动imageView的宽度
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)

        // 将imageView的 x 向右移动titleLabel的宽度
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
    }
}
