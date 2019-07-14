//
//  WBCommon.swift
//  Weibo
//
//  Created by liyishu on 2019/6/24.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

// MARK - 应用程序信息

/** 应用程序ID */
let WBAppKey = "1236293576"
/** 应用程序加密信息 */
let WBAppSecret = "1206617644d54af36f91faaa8fe552d4"
/** 回调地址 */
let WBRedirectUri = "https://baidu.com"

// MARK - 全局通知定义

// 用户需要登录通知
let WBUsershouldLoginNotification = "WBUsershouldLoginNotification"
// 用户登录成功通知
let WBUserLoginSucceedNotification = "WBUserLoginSucceedNotification"

// MARK: - 微博配图视图常量

// 配图视图外侧的间距
let WBStatusPictureViewOutterMargin = CGFloat(12)
// 配图视图内部图像视图的间距
let WBStatusPictureViewInnerMargin = CGFloat(3)
// 视图的宽度
let WBStatusPictureViewWidth = UIScreen.main.bounds.size.width - 2*WBStatusPictureViewOutterMargin
// 每个Item默认的宽度
let WBStatusPictureItemWidth = (WBStatusPictureViewWidth - 2*WBStatusPictureViewInnerMargin) / 3
