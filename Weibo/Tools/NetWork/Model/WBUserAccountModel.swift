//
//  WBUserAccountModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/29.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import YYModel

class WBUserAccountModel: NSObject {

    // 访问令牌
    var access_Token: String?
    
    // 用户代号
    var uid: String?
    
    // access_Token的生命周期
    var expires_in: TimeInterval = 0 {
        didSet {
            expiresDate = Date(timeIntervalSinceNow: expires_in)
        }
    }

    // access_Token过期日期
    var expiresDate: Date?
    override var description: String {
        return yy_modelDescription()
    }
}
