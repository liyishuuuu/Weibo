//
//  WBStatusPicture.swift
//  Weibo
//
//  Created by liyishu on 2019/7/14.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class WBStatusPicture: NSObject {

    // 缩略图地址
    @objc var thumbnail_pic: String?

    override var description: String {
        return yy_modelDescription()
    }
}
