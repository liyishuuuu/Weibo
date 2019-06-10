//
//  Bundle+Extensions.swift
//  Weibo
//
//  Created by liyishu on 2019/6/9.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation

extension Bundle {
    var namespace: String {
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
