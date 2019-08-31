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

    @IBOutlet weak var scrollView: UIScrollView!

    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字"],
                               ["imageName": "tabbar_compose_photo", "title": "照片"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_idea", "title": "文字"],
                               ["imageName": "tabbar_compose_idea", "title": "文字"],
                               ["imageName": "tabbar_compose_idea", "title": "文字"],
                               ["imageName": "tabbar_compose_idea", "title": "文字"],
                               ["imageName": "tabbar_compose_idea", "title": "文字"],
                               ]
    class func composeTypeView() -> WBComposeTypeView {
        let nib = UINib(nibName: "WBComposeTypeView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBComposeTypeView

        // Xib 加载默认600*600
        v.frame = UIScreen.main.bounds

        v.setupUI()
        return v
    }

    func show(){
        
        // 将当前视图添加到更视图控制器上
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        vc.view.addSubview(self)
    }

    // MARK: - 监听方法
    
    @objc private func buttonClick() {
     print("clicked")
    }

    // 关闭视图
    @IBAction func closeAction(_ sender: UIButton) {
        removeFromSuperview()
    }
}

private extension WBComposeTypeView {
    func setupUI() {
        
        // 强制更新布局
        layoutIfNeeded()

        // 向scrollView中添加视图
         let rect = scrollView.bounds

        let v = UIView()

        // 向视图中添加按钮
        addButton(v: v, idx: 0)

        // 将视图添加到scrollView中
        scrollView.addSubview(v)
    }

    // 向v中添加按钮, 数组的索引从 idx 开始
    func addButton(v: UIView, idx: Int) {
        let count = 6

        // 从idx开始添加六个按钮
        for i in idx..<(idx + count) {

            if idx >= buttonsInfo.count {
                break
            }

            // 从数组字典中获取图像名称和title
            let dict = buttonsInfo[i]
            guard let imageName = dict["imageName"],
                    let title = dict["title"] else {
                    continue
            }

            // 创建按钮
            let btn = WBComposeTypeButton.composeTypeButton(imageName: imageName, title: title)

            // 将btn 添加到视图
            v.addSubview(btn)
            
        }
        
    }
}
