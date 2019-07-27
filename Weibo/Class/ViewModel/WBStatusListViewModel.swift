//
//  WBStatusListViewModel.swift
//  Weibo
//
//  Created by liyishu on 2019/6/21.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import YYModel
import SDWebImage

/// 微博数据列表视图模型
/*
 如果需要使用‘KVC’或者字典装模型框架设置对象值，类就需要继承NSObject
 如果累只是包装了一些代码逻辑，可以不用任何父类，代码更轻量级
 如果是OC, 一律继承自NSObject
 */

/** 上拉刷新最大次数 */
private let maxPullUpTimes = 3

class WBStatusListViewModel: NSObject {

    // MARK: - 变量

    /** 微博视图模型数组懒加载 */
    lazy var statusList = [WBStatusViewModel]()
    
    /** 上拉刷新次数 */
    private var pullUpTimes = 0

    // MARK: - internal method

    /// 加载微博列表
    ///
    /// - Parameter isPullUp: 是否上拉刷新标记
    /// - Parameter completion: 完成回调(网络请求是否成功)
    internal func loadStatus(isPullUp: Bool, completion: @escaping (_ isSuccess: Bool, _ isMorePullUp: Bool) -> ()) {
        
        // 判断是否是上拉刷新，同时检查刷新次数
        if isPullUp && pullUpTimes > maxPullUpTimes {
            completion(true, false)
            return
        }
        // since_id: 取出数组的第一条微博id
        let since_id = isPullUp ? 0 : (statusList.first?.status.id ?? 0)
        
        // max_id: 取出数组的最后一条微博id
        let max_id = !isPullUp ? 0 : (statusList.last?.status.id ?? 0)

        // 发起网络请求，加载微博数据（字典数组）
        WBNetWorkManager.shared.statusList(since_id: since_id, max_id: max_id) { (list, isSuccess) in

            // 判断网络请求是否成功
            if !isSuccess {

                // 直接回调返回
                completion(false, false)
                return
            }

            // 字典转模型
            // 定义可变数组
            var array = [WBStatusViewModel]()

            // 遍历服务器返回的字典数组，字典转模型
            for dict in list ?? [] {

                // 创建微博模型
                let status = WBStatusModel()

                // 使用字典设置模型数值
                status.yy_modelSet(with: dict)

                // 使用微博模型设置微博视图模型
                let viewModel = WBStatusViewModel(model: status)

                // 添加到数组
                array.append(viewModel)
            }

            print("刷新到\(array.count)条数据\(array)")
            
            if isPullUp {

                // 上拉刷新
                // 将结果拼接在数组的末尾
                self.statusList += array
            } else {

                // 下拉刷新
                // 将结果拼接在数组的前面
                self.statusList = array + self.statusList
            }
            if isPullUp && array.count == 0 {
                self.pullUpTimes += 1
                completion(true, false)
            } else {
                self.cacheSinglePicture(list: array, completion: completion)
            }
        }
    }

    /// 缓存本次下载微博数据数组中的单张图像
    ///
    /// - Parameter list: 本次下载的视图模型数组
    private func cacheSinglePicture(list:[WBStatusViewModel],
                                    completion: @escaping (_ isSuccess: Bool, _ isMorePullUp: Bool) -> ()) {

        // 调度组
        let group = DispatchGroup()

        // 遍历list
        for vm in list {

            // 1.判断图像数量
            if vm.picURLs?.count != 1 {
                continue
            }

            // 数组中有且只有一张图片
            guard let pic = vm.picURLs?[0].thumbnail_pic,
                let url = URL(string: pic) else {
                    continue
            }
            print("要缓存的url: 是\(url)")

            // 下载图像
            // 图像下载完成后，自动保存在沙盒中，文件路径是url的MD5
            // 如果沙盒中存在，会先加载本地沙盒图像，不会发网络请求，回调方法同样会调用
            // A> 入组
            group.enter()
            SDWebImageManager.shared.loadImage(with: url, options: [], progress: nil) { (image, _, _, _, _, _) in
                print("缓存的图像是：\(image)")

                if let image = image {
                    vm.updateSingleImageSize(image: image)
                }

                // B> 出组 放在回调的最后一句
                group.leave()
            }
        }
        
        // 监听调度组情况
        group.notify(queue: DispatchQueue.main) {
            print("图像缓存完成")

            // 执行闭包回调
            completion(true, true)
        }
    }
}
