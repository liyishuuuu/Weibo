//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by liyishu on 2019/7/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class WBStatusViewModel: CustomStringConvertible {

    @objc var status: WBStatusModel

    @objc var memberIcon: UIImage?

    /// 构造函数
    ///
    /// - Parameter model: 单条微博视图模型
    init(model: WBStatusModel) {
        self.status = model

        if model.user?.mbrank ?? 0 > 0 && model.user?.mbrank ?? 0 < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }
    }

    var description: String {
        return status.description
    }
}
