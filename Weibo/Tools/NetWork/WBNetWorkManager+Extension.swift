//
//  WBNetWorkManager+Extension.swift
//  Weibo
//
//  Created by liyishu on 2019/6/20.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import YYModel

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

// MARK: - OAuth相关方法

extension WBNetWorkManager {

    
    // 加载AccessToken
    ///
    /// - Parameters:
    ///   - code: 授权码
    ///   - completion: 完成回调(是否成功)
    func loadAccessToken(code: String, completion: @escaping (_ isSuccess: Bool) -> ()) {

        // 设置url
        let urlString = "https://api.weibo.com/oauth2/access_token"

        // 设置参数
        let params = ["client_id": WBAppKey,
                      "client_secret": WBAppSecret,
                      "grant_type": "authorization_code",
                      "code": code,
                      "redirect_uri": WBRedirectUri]
        
        // 发起网络请求
        request(method: .POST, URLSting: urlString, parameters: params as [String : AnyObject]) { (json, isSuccess) in

            // 如果请求失败,对用户数据不会有任何影响
            // 直接用字典设置userAccount的属性
            self.userAccount.yy_modelSet(with: json as! [String: AnyObject])
            print("设置属性后\(self.userAccount)")

            // 保存模型
            self.userAccount.saveAccount()

            // 完成回调
            completion(isSuccess)
        }
    }
}
