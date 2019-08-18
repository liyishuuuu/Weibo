//
//  CZRefreshView.swift
//  Weibo
//
//  Created by liyishu on 2019/8/18.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

// 刷新视图
class CZRefreshView: UIView {

    // MARK: - 定义刷新状态

    var refreshState: CZRefreshState = .Normal {
        didSet {
            switch refreshState {
            case .Normal:
                tipLabel.text = "继续使劲。。。"
            case .Pulling:
                tipLabel.text = "放手就刷新。。。"
            case .WillRefresh:
                tipLabel.text = "正在刷新中。。。"
            }
        }
    }

    // MARK: - IBOutlet

    /** 提示图标 */
    @IBOutlet weak var tipIcon: UIImageView!
    /** 提示标签*/
    @IBOutlet weak var tipLabel: UILabel!
    /** 指示器 */
    @IBOutlet weak var indicate: UIActivityIndicatorView!

    class func redreshView() -> CZRefreshView {
        let nib = UINib(nibName: "CZRefreshView", bundle: nil)
        return nib.instantiate(withOwner: nil, options: nil)[0] as! CZRefreshView
    }
}
