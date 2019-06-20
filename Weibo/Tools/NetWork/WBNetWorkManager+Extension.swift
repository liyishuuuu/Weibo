//
//  WBNetWorkManager+Extension.swift
//  Weibo
//
//  Created by liyishu on 2019/6/20.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

// MARK: - 封装新浪微博的网络请求
extension WBNetWorkManager {

    /// 加载微博数据数组
    ///
    /// - Parameter completion: 完成回调
    func statusList(completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        let params = ["access_token": "2.00tV15KGehU_9B87cffd41cdGhkzoB"]

        request(URLSting: urlString, parameters: params as [String : AnyObject?]) { (json, isSuccess) in

            // 从json中获取status 字典数组，如果 as? 失败，result = nil  ****  statuses微博数组  ****
            let result =  json?["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
    }
}
