//
//  WBUserAccountModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/29.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import YYModel

class WBUserAccountModel: NSObject, Codable {

    // 访问令牌
    @objc var access_token: String?
    
    // 用户代号
    @objc var uid: String?
    
    // access_Token的生命周期 秒 递减
    @objc var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }

    // access_Token过期日期
    @objc var expiresDate: Date?

    // MARK: - override method

    override var description: String {
        return yy_modelDescription()
    }
    
    @objc func saveAccount() {

        // 1.模型转字典
        // 需要删除 expires_in
        let dict = self.yy_modelToJSONObject() as? [String: Any]
        
        
        // 2.字典序列化
        
        // 3.写入磁盘
    }
}
