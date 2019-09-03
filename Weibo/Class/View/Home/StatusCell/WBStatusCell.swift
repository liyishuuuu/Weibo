//
//  WBStatusCell.swift
//  Weibo
//
//  Created by liyishu on 2019/7/10.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBStatusCell: UITableViewCell {

    // 微博视图模型
    var viewModel: WBStatusViewModel? {
        didSet {

            // 微博文本
            statusLabel.text = viewModel?.status.text

            // 姓名
            nameLabel.text = viewModel?.status.user?.screen_name

            // 会员图标
            memberIconView.image = viewModel?.memberIcon
            
            // vip图标
            vipIconView.image = viewModel?.vipIcon
            
            // 用户头像
            iconView.cz_setImage(urlString: viewModel?.status.user?.profile_image_url,
                                 placeholderImage: UIImage(named: "avatar_default_big"),
                                 isAvadar: true)
            // 底部工具栏
            toolBar.viewModel = viewModel

            // 修改配图视图的高度
            pictureView.heightCons.constant = viewModel?.pictureViewSize.height ?? 0

            // 设置配图(被转发，和原创)
            pictureView.urls = viewModel?.picURLs

            // 被转发的微博的文字
            retweetedLabel?.text = viewModel?.retweetedText
    
            // 来源
            sourceLabel.text = viewModel?.status.source
            
        }
    }

    // MARK: - IBOutlet
    
    /** 头像 */
    @IBOutlet weak var iconView: UIImageView!
    /** 姓名 */
    @IBOutlet weak var nameLabel: UILabel!
    /** 会员图标 */
    @IBOutlet weak var memberIconView: UIImageView!
    /** 时间 */
    @IBOutlet weak var timeLabel: UILabel!
    /** 来源 */
    @IBOutlet weak var sourceLabel: UILabel!
    /** vip图片 */
    @IBOutlet weak var vipIconView: UIImageView!
    /** 微博内容 */
    @IBOutlet weak var statusLabel: UILabel!
    /** 底部工具栏 */
    @IBOutlet weak var toolBar: WBStatusToolBar!
    /** 配图视图 */
    @IBOutlet weak var pictureView: WBStatusPictureView!
    /** 配图视图与上部边距 */
    @IBOutlet weak var pictureTopCons: NSLayoutConstraint!
    /** 被转发微博内容 */
    @IBOutlet weak var retweetedLabel: UILabel?
    
    // MARK： - override method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // 加载完调用
        // 离屏渲染 - 异步绘制
        self.layer.drawsAsynchronously = true

        // 栅格化 - 异步绘制之后会生成一张独立的图像，cell在屏幕上滚动的时候，本质上滚动的是这张图片
        // cell 优化，x减少图层数量
        // 停止滚动后可以接受监听
        self.layer.shouldRasterize = true

        // 指定分辨率
        self.layer.rasterizationScale = UIScreen.main.scale

    }

}
