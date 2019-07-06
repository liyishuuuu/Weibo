//
//  WBUserAccountModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/29.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import YYModel

/** 用户信息文件 */
let accountFile = "userAccount.json"

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
    
    // 用户昵称
    @objc var screen_name: String?
    
    // 用户头像地址（大图），180×180像素
    @objc var avatar_large: String?

    // MARK: - override method

    override var description: String {
        return yy_modelDescription()
    }

    override init() {
        super.init()

        // 从磁盘加载保存的文件
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        guard let filePath = (docDir as? NSString)?.appendingPathComponent("userAccount.json"),
            let data = NSData(contentsOfFile: filePath),
            let dict = try? JSONSerialization.jsonObject(with: data as Data, options: []) as? [String: AnyObject]
            else {
                return
        }

        // 使用字典设置属性值
//        self.yy_modelSet(with: dict)
        print("使用字典从沙盒加载用户信息\(self)")

        // 判断token是否过期
        /** 测试日期过期代码 */
        /**** expiresDate = Date(timeIntervalSinceNow: -3600 * 24) */
        if expiresDate?.compare(Date()) != .orderedDescending {
            print("账户过期")

            // 清空token
            access_token = nil
            uid = nil

            // 删除账户文件
            print("文件路径: \(filePath)")
           _ = try? FileManager.default.removeItem(atPath: filePath)
        }
        print("账户正常\(self)")
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
