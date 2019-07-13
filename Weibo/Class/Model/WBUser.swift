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
    var id: Int64 = 0
    var screen_name: String?
    var profile_image_url: String?
    var verified_type: Int = 0
    var mbrank: Int = 0

    override var description: String {
        return yy_modelDescription()
    }
}
