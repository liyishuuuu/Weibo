//
//  WBNetWorkManager.swift
//  Weibo
//
//  Created by liyishu on 2019/6/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import AFNetworking  /// 导入框架文件夹的名字

/// swift 中支持任意数据类型
enum WBHttpMethod {
    case GET
    case POST
}
// 网络管理工具
class WBNetWorkManager: AFHTTPSessionManager {
    
    /// 静态区，常量，闭包
    static let shared = WBNetWorkManager()

    /// 封装 AFN 的GET/POST 请求
    ///
    /// - Parameters:
    ///   - method: GET/POST
    ///   - URLSting: URLSting
    ///   - parameters: 参数字典
    ///   - completion: 完成回调 json(数组/字典), 是否成功
    func request(method: WBHttpMethod = .GET, URLSting: String, parameters: [String: AnyObject?], completion: @escaping (_ json: AnyObject?, _ isSuccess: Bool)->()) {
        
        let success = { (task: URLSessionDataTask, json: Any?) ->() in
            completion(json as AnyObject?, true)
        }
        let failure =  {(task: URLSessionDataTask?, Error: Error) ->() in
            print("网络请求错误\(Error)")
            completion(nil, false)
        }
        if method == .GET {
            get(URLSting, parameters: parameters, progress: nil, success: success, failure: failure)
        } else {
            post(URLSting, parameters: parameters, progress: nil, success: success, failure: failure)
        }
    }
    
}
