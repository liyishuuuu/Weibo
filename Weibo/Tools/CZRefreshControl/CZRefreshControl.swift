//
//  CZRefreshControl.swift
//  Weibo
//
//  Created by liyishu on 2019/7/28.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 刷新控件状态
///
/// - Normal: 普通状态，什么也不做
/// - Pulling: 超过临界点，如果放手，开始刷新
/// - WillRefresh: 用户超过临界点并且放手
enum CZRefreshState {
    case Normal
    case Pulling
    case WillRefresh
}

/** 刷新控件的临界点 */
private let CZRefreshOffset: CGFloat = 60

// 刷新控件
class CZRefreshControl: UIControl {

    // MARK: - 属性

    // 刷新视图的父视图，下拉刷新控件应该适用于UItableView UICollectionView
    private weak var scrollView: UIScrollView?
    
    // refreshView
    private lazy var refreshView: CZRefreshView = CZRefreshView.redreshView()

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

        // 初始高度为0
        let height = -(sv.contentInset.top + sv.contentOffset.y)

        if height < 0 {
            return
        }

        //可以根据高度计算刷新控件的frame
        self.frame = CGRect(x: 0,
                            y: -height,
                            width: sv.bounds.width,
                            height: height)

        print(height)

        if sv.isDragging {
            if height > CZRefreshOffset && (refreshView.refreshState == .Normal) {
                print("放手刷新")
                refreshView.refreshState = .Pulling
            } else if height <= CZRefreshOffset && (refreshView.refreshState == .Pulling){
                print("再使劲")
                refreshView.refreshState = .Normal
            }
        } else {
            if refreshView.refreshState == .Pulling {
                print("放手刷新")
                //刷新结束之后，将状态改为.Normal 才能继续响应刷新
                refreshView.refreshState = .WillRefresh
            }
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
        backgroundColor = UIColor.white

        // 设置超出边界不显示
        clipsToBounds = true
        // 添加刷新视图
        addSubview(refreshView)
        // 自动布局
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .width,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.width))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))
    }
}
