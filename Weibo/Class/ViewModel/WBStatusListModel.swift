//
//  WBStatusListModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

/// 微博数据列表视图模型
/*
 如果需要使用‘KVC’或者字典装模型框架设置对象值，类就需要继承NSObject
 如果累只是包装了一些代码逻辑，可以不用任何父类，代码更轻量级
 如果是OC, 一律继承自NSObject
 */
class WBStatusListModel {

    //微博模型数组懒加载
    lazy var statusList = [WBStatusModel]()

    /// 加载微博列表
    ///
    /// - Parameter completion: 完成回调(网络请求是否成功)
    func loadStatus(completion: @escaping (_ isSuccess: Bool) -> ()) {
        WBNetWorkManager.shared.statusList { (list, isSuccess) in
            // 字典转模型
            guard let array = NSArray.yy_modelArray(with: WBStatusModel.self, json: list ?? []) as? [WBStatusModel]
                else {
                    completion(isSuccess)
                return
            }
            // 拼接数据
            self.statusList += array
            
            // 完成回调
            completion(isSuccess)
        }
    }
}
