//
//  WBStatusViewModel.swift
//  Weibo
//
//  Created by liyishu on 2019/7/13.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

class WBStatusViewModel {
    
    var status: WBStatusModel
    
    /// 构造函数
    ///
    /// - Parameter model: 单条微博视图模型
    init(model: WBStatusModel) {
        self.status = model
    }
}
