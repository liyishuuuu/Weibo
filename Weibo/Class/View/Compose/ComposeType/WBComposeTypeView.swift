//
//  WBComposeTypeView.swift
//  Weibo
//
//  Created by liyishu on 2019/8/25.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

// 撰写微博类型视图
class WBComposeTypeView: UIView {

    class func composeTypeView() -> WBComposeTypeView {
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView

        // Xib 加载默认600*600
        v.frame = UIScreen.main.bounds
        return v
    }

    func show(){
        
        // 将当前视图添加到更视图控制器上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupUI()
    }

    // MARK: - 监听方法
    
    @objc private func buttonClick() {
     print("clicked")
    }
}

private extension WBComposeTypeView {
    func setupUI() {

        // 创键类型按钮
        let btn = WBComposeTypeButton.composeTypeButton(imageName: "tabbar_compose_camera", title: "拍摄视频")
        btn.center = center

        // 添加视图
        addSubview(btn)

        // 添加监听方法
        btn.addTarget(self, action: #selector(buttonClick), for: .touchUpInside)
    }
}
