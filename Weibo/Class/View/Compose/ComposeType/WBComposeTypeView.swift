//
//  WBComposeTypeView.swift
//  Weibo
//
//  Created by liyishu on 2019/8/25.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import pop

// 撰写微博类型视图
class WBComposeTypeView: UIView {

    // 滚动视图
    @IBOutlet weak var scrollView: UIScrollView!
    // 返回按钮
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

        // 添加视图
        vc.view.addSubview(self)

        // 开始动画
        showCurrentView()
        
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

    @IBAction func backButtonAction(_ sender: UIButton) {

        // 将滚动视图滚动到第一页
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)

        // 让两个按钮合并
        closeButtonCenterXCons.constant = 0
        backButtonCenterXCons.constant = 0
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
            self.backButton.alpha = 0
        }) { (_) in
            self.backButton.isHidden = true
            self.backButton.alpha = 1
        }
    }
    // 关闭视图
    @IBAction func closeAction(_ sender: UIButton) {
        hideButtons()
    }
}

// 动画方法扩展
private extension WBComposeTypeView {

    // MARK: 消除部分动画
    
    // 隐藏按钮动画
    private func hideButtons() {
        
        // 根据contentOffset 判断当前视图的子视图
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        let v = scrollView.subviews[page]

        // 遍历v中的所有按钮
        for (i, btn) in v.subviews.enumerated().reversed() {

            // i 从最后一个 开始 5 4 3 2 1
            // 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)

            // 设置动画属性
            anim.fromValue = btn.centerY
            anim.toValue = btn.centerY + 350

            // 设置时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(v.subviews.count - i) * 0.025
            
            // 添加动画
            btn.layer.pop_add(anim, forKey: nil)

            // 隐藏当前视图 开始时间 ， 监听第0个按钮
            if i == 0 {
                anim.completionBlock = {(_, _) -> () in
                    self.hideCurrentView()
                }
            }
        }
    }

    // 影藏当前视图
    private func hideCurrentView() {

        // 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)

        // 设置动画
        anim.fromValue = 1
        anim.toValue = 0
        anim.duration = 0.25

        // 添加动画
        pop_add(anim, forKey: nil)

        // 添加完成监听方法
        anim.completionBlock = {(_, _) in
            self.removeFromSuperview()
        }
    }

    // MARK: 显示部分的动画

    // 动画显示当前视图
    private func showCurrentView() {

        // 创建动画
        let anim: POPBasicAnimation = POPBasicAnimation(propertyNamed: kPOPViewAlpha)
        anim.fromValue = 0
        anim.toValue = 1
        anim.duration = 0.25
        
        // 添加到视图
        pop_add(anim, forKey: nil)

        // 添加动画按钮
        showButtons()
    }

    // 弹力显示所有的按钮
    private func showButtons() {

        // 获取scrollView 子视图的第0个视图
        let v = scrollView.subviews[0]
        for (i,btn) in v.subviews.enumerated() {

            // 创建动画
            let anim: POPSpringAnimation = POPSpringAnimation(propertyNamed: kPOPLayerPositionY)

            // 设置动画属性
            anim.fromValue = btn.center.y + 350
            anim.toValue = btn.center.y

            // 设置弹性
            anim.springBounciness = 6

            // 弹力速度
            anim.springSpeed = 10

            // 设置动画启动时间
            anim.beginTime = CACurrentMediaTime() + CFTimeInterval(i) * 0.025

            // 添加动画
            btn.pop_add(anim, forKey: nil)
        }
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
