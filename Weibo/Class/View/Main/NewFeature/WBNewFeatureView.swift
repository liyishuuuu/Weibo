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
    }
}
