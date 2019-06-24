//
//  WBVisitorView.swift
//  Weibo
//
//  Created by liyishu on 2019/6/16.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBVisitorView: UIView {

    /// 访客视图字典信息 [imageName/message]
    /// 如果是首页 imageName = ""
    var visitorInfo: [String: String]? {
        didSet {
            // 1.取字典信息
            guard let immageName = visitorInfo?["imageName"],
                let message = visitorInfo?["message"] else {
                    return
            }
            
            // 2.设置消息
            tipLabel.text = message
            
            // 3.设置图像，首页不需要设置
            if immageName == "" {
                self.startAnimaiton()
                return
            }
            iconView.image = UIImage(named: immageName)
            
            // 其他画面不需要显示小房子、遮罩视图
            houseIconView.isHidden = true
            maskIconView.isHidden = true
        }
    }
    /// 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func startAnimaiton() {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * Double.pi
        anim.repeatCount = MAXFLOAT
        anim.duration = 15
        ///*** 动画完成不删除，如果iconView 销毁，动画会一起销毁
        ///*** 在设置连续播放的时候非常有效
        anim.isRemovedOnCompletion = false
        iconView.layer.add(anim, forKey: nil)
    }
    // 私有控件
    ///懒加载属性只有调用UIKit指定的构造函数，其他的都需要使用类型
    /// 图像视图
    private lazy var iconView: UIImageView = UIImageView(image:
        UIImage(named: "visitordiscover_feed_image_smallicon"))

    // mask图像
    private lazy var  maskIconView: UIImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))

    /// 小房子
    private lazy var houseIconView: UIImageView = UIImageView(image:
        UIImage(named: "visitordiscover_feed_image_house"))
    
    /// 提示标签
    private lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.text = "关注一些人，回这里看看有什么惊喜"
        tipLabel.font = UIFont(name: tipLabel.text ?? "", size: 14)
        tipLabel.textColor = UIColor.gray
        return tipLabel
    }()

    /// 注册按钮
    lazy var registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(.orange, for: .normal)
        registerButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        return registerButton
    }()

    /// 登录按钮
    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.darkGray, for: .normal)
        loginButton.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: .normal)
        return loginButton
    }()
}
extension WBVisitorView {
    func setupUI() {
//        backgroundColor = UIColor.colorWithHex(0xEDEDED)
        backgroundColor = UIColor.init(hexString: "0xEDEDED")
        
        // 1.添加控件
        addSubview(iconView)
        addSubview(maskIconView)
        addSubview(houseIconView)
        addSubview(registerButton)
        addSubview(loginButton)
        addSubview(tipLabel)

        //  文本居中
        tipLabel.textAlignment = .center
        
        // 2.取消autoresizing
        for v in subviews {
            v.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 3.自动布局
        
        let margin: CGFloat = 20
        // 图像视图
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: iconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: -60))
        // 小房子
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: houseIconView,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0))
        /// 提示标签
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: iconView,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: tipLabel,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 285))
        /// 注册按钮
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .left,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .left,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: registerButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: 100))
        /// 登录按钮
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .right,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .right,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .top,
                                         relatedBy: .equal,
                                         toItem: tipLabel,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: margin))
        addConstraint(NSLayoutConstraint(item: loginButton,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: registerButton,
                                         attribute: .width,
                                         multiplier: 1.0,
                                         constant: 0))
        
        /// mask 图像
        /// views 定义VFL中控件名称和实际名称的映射关系
        let viewDict = ["maskIconView": maskIconView, "registerButton": registerButton]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[maskIconView]-0-|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewDict))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[maskIconView]-0-[registerButton]",
                                                      options: [],
                                                      metrics: nil,
                                                      views: viewDict))
    }
}

