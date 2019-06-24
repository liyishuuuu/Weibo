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
    func statusList(since_id: Int64 = 0, max_id: Int64 = 0, completion: @escaping (_ list: [[String: AnyObject]]?, _ isSuccess: Bool) -> ()) {
        
        /// url地址
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json"
        
        /// 参数
        let params = ["since_id": "\(since_id)", "max_id": "\(max_id > 0 ? max_id - 1 : 0)"]
        tokenRequest(URLSting: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in

            // 从json中获取status 字典数组，如果 as? 失败，result = nil  ****  statuses微博数组  ****
            let result =  json?["statuses"] as? [[String: AnyObject]]
            completion(result, isSuccess)
        }
    }
}
