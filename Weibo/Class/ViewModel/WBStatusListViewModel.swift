//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import YYModel

/// 微博数据列表视图模型
/*
 如果需要使用‘KVC’或者字典装模型框架设置对象值，类就需要继承NSObject
 如果累只是包装了一些代码逻辑，可以不用任何父类，代码更轻量级
 如果是OC, 一律继承自NSObject
 */

/** 上拉刷新最大次数 */
private let maxPullUpTimes = 3

class WBStatusListViewModel: NSObject {

    // MARK: - 变量

    /** 微博模型数组懒加载 */
    @objc lazy var statusList = [WBStatusModel]()
    
    /** 上拉刷新次数 */
    private var pullUpTimes = 0

    // MARK: - internal method

    /// 加载微博列表
    ///
    /// - Parameter isPullUp: 是否上拉刷新标记
    /// - Parameter completion: 完成回调(网络请求是否成功)
    internal func loadStatus(isPullUp: Bool, completion: @escaping (_ isSuccess: Bool, _ isMorePullUp: Bool) -> ()) {
        
        // 判断是否是上拉刷新，同时检查刷新次数
        if isPullUp && pullUpTimes > maxPullUpTimes {
            completion(true, false)
            return
        }
        // since_id: 取出数组的第一条微博id
        let since_id = isPullUp ? 0 : (statusList.first?.id ?? 0)
        
        // max_id: 取出数组的最后一条微博id
        let max_id = !isPullUp ? 0 : (statusList.last?.id ?? 0)

        WBNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in

            // 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatusModel.self, json: list ?? []) as? [WBStatusModel] else {
                completion(true, false)
                return
            }
            print("刷新到\(array.count)条数据")
            
            if isPullUp {

                // 上拉刷新
                // 将结果拼接在数组的末尾
                self.statusList += array
            } else {

                // 下拉刷新
                // 将结果拼接在数组的前面
                self.statusList = array + self.statusList
            }
            if isPullUp && array.count == 0 {
                self.pullUpTimes += 1
                completion(true, false)
            } else {

                // 完成回调
                completion(true, true)
            }
        }
    }
}
