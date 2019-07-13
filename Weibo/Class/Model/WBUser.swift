//
//  WBUser.swift
//  Weibo
//
//  Created by liyishu on 2019/7/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

/// 微博用户模型
class WBUser: NSObject {

    /** 用户ID */
    var id: Int64 = 0

    /** 用户昵称 */
    var screen_name: String?

    /** 用户头像地址（中图），50×50像素 */
    var profile_image_url: String?

    /** 微博认证用户 */
    var verified_type: Int = 0

    /** 会员等级 */
    var mbrank: Int = 0

    override var description: String {
        return yy_modelDescription()
    }
}
