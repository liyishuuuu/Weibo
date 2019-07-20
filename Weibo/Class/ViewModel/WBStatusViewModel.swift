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
    /** 配图视图大小 */
    @objc var pictureViewSize = CGSize()
    /** 如果是被转发的微博，原创微博一定没有图 */
    @objc var picURLs: [WBStatusPicture]? {
        // 如果有被转发的微博，返回被转发的微博的配图
        // 如果没有被转发的微博，返回原创微博的配图
        // 如果都没有，返回nil
        return status.retweeted_status?.pic_urls ?? status.pic_urls
        
    }
    /** 被转发微博的文字 */
    @objc var retweetedText: String?

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

        // 计算配图视图 大小(有原创的就计算原创的，转发的就计算转发的)
        pictureViewSize = calcPictureViewSize(count: picURLs?.count)
        
        // 设置被转发微博文字
        let retweetedTextTemp: String = "@" + (status.retweeted_status?.user?.screen_name ?? "") + ":"
        retweetedText = retweetedTextTemp + (status.retweeted_status?.text ?? "")
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

    private func calcPictureViewSize(count: Int?) -> CGSize {
        if count == 0 {
            return CGSize()
        }
        // 计算配图视图的宽度
        // 计算高度
        // 行数
        let row = (count! - 1) / 3 + 1
        // 根据行数计算高度
        var height = WBStatusPictureViewOutterMargin
            height += CGFloat(row - 1)*WBStatusPictureViewInnerMargin
            height += CGFloat(row)*WBStatusPictureItemWidth
        return CGSize(width: WBStatusPictureViewWidth, height: height)
    }
}
