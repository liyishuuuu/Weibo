//
//  WBWelcome.swift
//  Weibo
//
//  Created by liyishu on 2019/7/6.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

// 欢迎视图
class WBWelcomeView: UIView {

    /** 头像 */
    @IBOutlet weak var iconView: UIImageView!
    /** 说明文字 */
    @IBOutlet weak var tipLabel: UILabel!
    /** 底部约束 */
    @IBOutlet weak var BottunCons: NSLayoutConstraint!

    class func welcomeView() -> WBWelcomeView {
        let nib = UINib(nibName: "WBWelcomeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBWelcomeView
        v.frame = UIScreen.main.bounds
        return v
    }
    
    /**
     * 视图被添加到window上
     */
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        // layoutIfNeeded 会直接按照当前的约束直接更新控件位置
        // 执行之后，控件所在的位置，就是XIB中布局的位置
        self.layoutIfNeeded()
        BottunCons.constant = bounds.size.height - 200
        
        // 如果控件们的约束还没有计算好，所有约束会一起动画
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0,
                       options: [],
                       animations: {

                        // 更新约束
                        self.layoutIfNeeded()
        }, completion: { (_) in
        })
    }
}
