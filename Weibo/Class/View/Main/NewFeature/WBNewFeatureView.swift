//
//  WBNewFeatureView.swift
//  Weibo
//
//  Created by liyishu on 2019/7/6.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 新特性视图
class WBNewFeatureView: UIView {
    
    /** scrollView */
    @IBOutlet weak var scrollView: UIScrollView!
    /** 进入按钮 */
    @IBOutlet weak var enterButton: UIButton!
    /** pageControl */
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func enterstatus(_ sender: UIButton) {
        removeFromSuperview()
    }

    // MARK: - class method
    
    class func newFeatureView() -> WBNewFeatureView {
        let nib = UINib(nibName: "WBNewFeatureView", bundle: nil)
        let v = nib.instantiate(withOwner: nil, options: nil)[0] as! WBNewFeatureView
        v.frame = UIScreen.main.bounds
        return v
    }

    override func awakeFromNib() {

        // 添加4个图像视图
        let count = 4
        let rect = UIScreen.main.bounds

        for i in 0..<count {
            let imageName = "new_feature_\(i+1)"
            let iv = UIImageView(image: UIImage(named: imageName))
            
            // 设置大小
            iv.frame = rect.offsetBy(dx: CGFloat(i) * rect.width, dy: 0)
            
            scrollView.addSubview(iv)
        }
        
        // 指定scrollView的属性
        scrollView.contentSize = CGSize(width: CGFloat(count + 1) * rect.width, height: rect.height)
        enterButton.isHidden = true
        
        // 设置scrollView的代理
        scrollView.delegate = self
    }
}

extension WBNewFeatureView: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        // 滚动到最后一屏，让视图删除
        let page = scrollView.contentOffset.x / scrollView.bounds.width

        // 判断是最后一页，删除视图
        if page == CGFloat(scrollView.subviews.count) {
            removeFromSuperview()
        }

        // 判断是倒数第二页，显示按钮
        enterButton.isHidden = (page != CGFloat(scrollView.subviews.count - 1))
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        // 0.一旦滚动，隐藏按钮
        enterButton.isHidden = true

        // 1.计算当前偏移量
        let page = scrollView.contentOffset.x / scrollView.bounds.width + 0.5

        // 设置分页控件
        pageControl.currentPage = Int(page)
    }
}
