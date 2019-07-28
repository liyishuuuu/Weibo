//
//  CZRefreshControl.swift
//  Weibo
//
//  Created by liyishu on 2019/7/28.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

// 刷新控件
class CZRefreshControl: UIControl {

    // MARK: - 属性

    // 刷新视图的父视图，下拉刷新控件应该适用于UItableView UICollectionView
    private weak var scrollView: UIScrollView?

    // 构造函数
    override init(frame: CGRect) {
        super.init(frame: CGRect())
        self.setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupUI()
    }

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)

        // 判断父视图
        guard let sv = newSuperview as? UIScrollView else {
            return
        }

        // 记录父视图
        scrollView = sv

        // KVO 监听 父视图的 contentOffset
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
    }
    
    // 所有
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let sv = scrollView else {
            return
        }
        let height = -(sv.contentInset.top + sv.contentOffset.y)
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)
    }

    // May be used to indicate to the refreshControl that an external event has initiated the refresh action
    func beginRefreshing() {
        
    }

    // Must be explicitly called when the refreshing has completed
    func endRefreshing() {
        
    }
}

extension CZRefreshControl {
    private func setupUI() {
        backgroundColor = UIColor.orange
    }
}
