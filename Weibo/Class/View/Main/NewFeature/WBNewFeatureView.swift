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
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
