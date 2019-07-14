//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by liyishu on 2019/7/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {
    @IBOutlet weak var heightCons: NSLayoutConstraint!
    override func awakeFromNib() {
        setupUI()
    }
}

// MARK: - 设置界面
extension WBStatusPictureView {
    private func setupUI() {
        clipsToBounds = true
        let count = 3
        let rect = CGRect(x: 0,
                          y: WBStatusPictureViewOutterMargin,
                          width: WBStatusPictureItemWidth,
                          height: WBStatusPictureItemWidth)
        for i in 0..<count * count {
            
            let iv = UIImageView()
            iv.backgroundColor = UIColor.red

            // 行
            let row = CGFloat(i / count)
            // 列
            let col = CGFloat(i % count)

            let xOffset = col*(WBStatusPictureViewInnerMargin + WBStatusPictureItemWidth)
            let yOffset = row*(WBStatusPictureViewInnerMargin + WBStatusPictureItemWidth)
            iv.frame = rect.offsetBy(dx: xOffset, dy: yOffset)
            addSubview(iv)
        }
    }
}
