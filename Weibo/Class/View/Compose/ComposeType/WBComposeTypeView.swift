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
    @IBOutlet weak var backButton: UIButton!
    // 返回按钮约束
    @IBOutlet weak var backButtonCenterXCons: NSLayoutConstraint!
    // 关闭按钮约束
    @IBOutlet weak var closeButtonCenterXCons: NSLayoutConstraint!

    private let buttonsInfo = [["imageName": "tabbar_compose_idea", "title": "文字"],
                               ["imageName": "tabbar_compose_photo", "title": "照片"],
                               ["imageName": "tabbar_compose_weibo", "title": "长微博"],
                               ["imageName": "tabbar_compose_lbs", "title": "签到"],
                               ["imageName": "tabbar_compose_review", "title": "点评"],
                               ["imageName": "tabbar_compose_more", "title": "更多", "actionName": "clickMore"],
                               ["imageName": "tabbar_compose_music", "title": "音乐"],
                               ["imageName": "tabbar_compose_shooting", "title": "录像"],
                               ["imageName": "tabbar_compose_transfer", "title": "转账"],
                               ["imageName": "tabbar_compose_video", "title": "视频"],
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

    // 点击更多按钮
    @objc private func clickMore() {

        // 滚动到第二页
        scrollView.setContentOffset(CGPoint(x: scrollView.bounds.width, y: 0), animated: true)

        // 处理底部按钮，让两个按钮分开
        backButton.isHidden = false

        let margin = scrollView.bounds.width / 6
        closeButtonCenterXCons.constant += margin
        backButtonCenterXCons.constant -= margin
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }

    @IBAction func backButtonAction() {

        // 将滚动视图滚动到第一页
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        closeButtonCenterXCons.constant = 0
        backButtonCenterXCons.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
        }) { (_) in

            // 让两个按钮合并
            self.backButton.isHidden = true
        }
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
        let width = scrollView.bounds.width
        for i in 0..<2 {
            let v = UIView(frame: rect.offsetBy(dx: CGFloat(i) * width, dy: 0))
            
            // 向视图中添加按钮
            addButton(v: v, idx: i*6)

            // 将视图添加到scrollView中
            scrollView.addSubview(v)
        }

        // 设置scrollView
        scrollView.contentSize = CGSize(width: 2 * width, height: 0)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false

        // 禁用滚动
        scrollView.isScrollEnabled = false
        
    }

    // 向v中添加按钮, 数组的索引从 idx 开始
    func addButton(v: UIView, idx: Int) {
        let count = 6

        // 从idx开始添加六个按钮
        for i in idx..<(idx + count) {

            if i >= buttonsInfo.count {
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

            // 添加监听方法
            if let actionName = dict["actionName"] {
                btn.addTarget(self, action: Selector(actionName), for: .touchUpInside)
            }
        }
        // 遍历视图的子视图，布局按钮
        let btnSize = CGSize(width: 100, height: 100)
        let margin = (v.bounds.width - 3 * btnSize.width) / 4
        
        for(i, btn) in v.subviews.enumerated() {
            let y: CGFloat = (i > 2) ? (v.bounds.height - btnSize.height - 20) : 0
            let col = i % 3
            let x = CGFloat(col + 1) * margin + CGFloat(col) * btnSize.width
            btn.frame = CGRect(x: x, y: y, width: btnSize.width, height: btnSize.height)
        }
    }
}
