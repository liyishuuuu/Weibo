//
//  WBStatusModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import YYModel

/// 微博数据模型
class WBStatusModel: NSObject {

    /** 微博id */
    /// Int 类型，在64位机器是64位，在32位机器是32位
    @objc var id: Int64 = 0

    /** 微博信息内容 */
    @objc var text: String?

    /** 用户 */
    @objc var user: WBUser?
    
    /** 转发数 */
    @objc var reposts_count: Int = 0
    
    /** 评论数 */
    @objc var comments_count: Int = 0
    
    /** 表态数 */
    @objc var attitudes_count: Int = 0

    /** 重写description的计算型属性 */
    override var description: String {
        return yy_modelDescription()
    }
}
