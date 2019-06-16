//
//  WBVisitorView.swift
//  Weibo
//
//  Created by liyishu on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 私有控件
    ///懒加载属性只有调用UIKit指定的构造函数，其他的都需要使用类型
    /// 图像视图
    private lazy var iconView: UIImageView = UIImageView(image:
        UIImage(named: "visitordiscover_feed_image_smallicon"))

    /// 小房子
    private lazy var houseIconView: UIImageView = UIImageView(image:
        UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 提示标签
    private lazy var tipLabel = {
        let tipLabel = UILabel()
        tipLabel.text = "关注一些人，回这里看看有什么惊喜"
        tipLabel.font = UIFont(name: tipLabel.text ?? "", size: 14)
        tipLabel.textColor = UIColor.gray
    }

    /// 注册按钮
    private lazy var registerButton = {
        let registerButton = UIButton()
        registerButton.setTitle("注册", for: .normal)
        registerButton.tintColor = UIColor.orange
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
    }

    /// 登录按钮
    private lazy var loginButton = {
        let loginButton = UIButton()
        loginButton.setTitle("登录", for: .normal)
        loginButton.tintColor = UIColor.gray
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
    }
}
extension WBVisitorView {
    func setupUI() {
        backgroundColor = UIColor.white
    }
}

