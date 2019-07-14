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

    /** 微博数据类型 */
    @objc var status: WBStatusModel
    /**  会员图标 */
    @objc var memberIcon: UIImage?
    /**  vip等级 */
    @objc var vipIcon: UIImage?
    /** 转发文字 */
    @objc var retweetedStr: String?
    /** 评论文字 */
    @objc var commentStr: String?
    /** 赞文字 */
    @objc var likeStr: String?

    /// 构造函数
    ///
    /// - Parameter model: 单条微博视图模型
    init(model: WBStatusModel) {
        self.status = model

        // 判断会员等级
        if model.user?.mbrank ?? 0 > 0 && model.user?.mbrank ?? 0 < 7 {
            let imageName = "common_icon_membership_level\(model.user?.mbrank ?? 1)"
            memberIcon = UIImage(named: imageName)
        }

        // 判断vip类型
        switch model.user?.verified_type {
        case 0:
            vipIcon = UIImage(named: "avatar_vip")
        case 2,3,5:
            vipIcon = UIImage(named: "avatar_enterprise_vip")
        case 220:
            vipIcon = UIImage(named: "avatar_grassroot")
        default:
            break
        }

        // 设置底部计数字符串
        retweetedStr = countString(count: status.reposts_count, defaultString: "转发")
        commentStr = countString(count: status.comments_count, defaultString: "评论")
        likeStr = countString(count: status.attitudes_count, defaultString: "赞")
    }

    var description: String {
        return status.description
    }

    /// 给一个数字，返回对应的描述结果
    ///
    /// - Parameters:
    ///   - count: 数字
    ///   - defaultString: 默认字符串
    private func countString(count: Int, defaultString: String) -> String {
        if count == 0 {
            return defaultString
        }

        if count < 10000 {
            return count.description
        }

        return String(format: "%.02f 万", Double(count) / 10000)
    }
}
