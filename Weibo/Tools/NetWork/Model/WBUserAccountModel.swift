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
        var dict = (self.yy_modelToJSONObject() as? [String: Any]) ?? [:]

        // 需要删除 expires_in
        dict.removeValue(forKey: "expires_in")

        // 2.字典序列化
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        guard let data = try? JSONSerialization.data(withJSONObject: dict, options: []),
              let filePath = (docDir as? NSString)?.appendingPathComponent("userAccount.json") else {
            return
        }

        // 3.写入磁盘
        (data as NSData).write(toFile: filePath, atomically: true)
        print("保存账户成功\(filePath)")
    }
}
