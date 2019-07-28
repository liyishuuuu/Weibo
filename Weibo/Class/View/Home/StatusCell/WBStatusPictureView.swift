//
//  WBStatusPictureView.swift
//  Weibo
//
//  Created by liyishu on 2019/7/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBStatusPictureView: UIView {

    var viewModel: WBStatusViewModel? {
        didSet {
            calcViewSize()
        }
    }

    // 根据配图视图大小，调整显示内容
    private func calcViewSize() {

        // 处理宽度
        // 单图 根据配图视图的大小，修改subViews[0] 的宽高
        if viewModel?.picURLs?.count == 1 {
            let viewSize = viewModel?.pictureViewSize ?? CGSize()
            
            // 获取第0个图像视图
            let v = subviews[0]
            v.frame = CGRect(x: 0,
                             y: WBStatusPictureViewOutterMargin,
                             width: viewSize.width,
                             height: viewSize.height)
        } else {

            // 多图(无图) 恢复subViews[0]的宽高，保证九宫格的完整
            let v = subviews[0]
            v.frame = CGRect(x: 0,
                             y: WBStatusPictureViewOutterMargin,
                             width: WBStatusPictureItemWidth,
                             height: WBStatusPictureItemWidth)
            
        }
        
        // 修改配图视图的高度约束
        heightCons.constant = viewModel?.pictureViewSize.height ?? 0
    }

    // 配图视图数组
    var urls: [WBStatusPicture]? {
        didSet {
            // 1.隐藏所有的imageView
            for v in subviews {
                v.isHidden = true
            }

            // 遍历 urls数组，顺序设置图像
            var index = 0
            for url in urls ?? [] {

                // 获得索引的imageView
                let iv = subviews[index] as! UIImageView

                // 设置图像
                iv.cz_setImage(urlString: url.thumbnail_pic, placeholderImage: nil)

                // 显示图像
                iv.isHidden = false
                index += 1
            }
        }
    }

    @IBOutlet weak var heightCons: NSLayoutConstraint!
    override func awakeFromNib() {
        setupUI()
    }
}

// MARK: - 设置界面
extension WBStatusPictureView {
    private func setupUI() {
        // 设置背景颜色
        backgroundColor = super.backgroundColor

        // 超出边界的内容不显示
        clipsToBounds = true
        let count = 3
        let rect = CGRect(x: 0,
                          y: WBStatusPictureViewOutterMargin,
                          width: WBStatusPictureItemWidth,
                          height: WBStatusPictureItemWidth)
        for i in 0..<count * count {
            
            let iv = UIImageView()
            
            // 设置contentMode
            iv.contentMode = .scaleToFill
            iv.clipsToBounds = true

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
