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

    /**
     willMove addSubView 方法会调用
     当添加到父视图的时候，newSuperView 是父视图
     当父视图被移除时，newSuperView是nil
     */
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

    /**
     本视图从父视图上移除
     所有的下拉刷新框架都是监听父视图的contentOffset
     所有框架的KVO监听实现思路都是这个
     */
    override func removeFromSuperview() {
        
        // superView 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        super.removeFromSuperview()
        // superView不存在
        
        
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
