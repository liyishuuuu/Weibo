//
//  WBNetWorkManager.swift
//  Weibo
//
//  Created by liyishu on 2019/6/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import AFNetworking  /// 导入框架文件夹的名字

// 网络管理工具
class WBNetWorkManager: AFHTTPSessionManager {
    /// 静态区，常量，闭包
    static let shared = WBNetWorkManager()
}
