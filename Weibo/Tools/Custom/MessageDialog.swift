//
//  SwiftView.swift
//  MessageDialog
//
//  Created by liyishu on 2019/8/10.
//  Copyright © 2019年 Apple. All rights reserved.
//
import UIKit
import Foundation

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

class MessageDialog: UIView {

    // 声明闭包，点击按钮传值
    typealias clickAlertClosure = (_ index: Int) -> Void
    // 把申明的闭包设置成属性
    var clickClosure: clickAlertClosure?
    // 为闭包设置调用函数
    func clickIndexClosure(_ closure: clickAlertClosure?){
        // 将函数指针赋值给myClosure闭包
        clickClosure = closure
    }

    // 弹框控件
    // 背景
    var bgView = UIView()
    // 标题
    var titleLable = UILabel()
    // 内容
    var contentLabel: UILabel? = UILabel()
    // 滑动
    var scrollView = UIScrollView()
    // 取消按钮
    let cancelButton = UIButton()
    // 确定按钮
    let confirmButton = UIButton()
    
    init(title: String?, message: String?, cancelButtonTitle: String?, confirmButtonTitle: String?) {
        super.init(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        createDialog(message: message!)
        self.titleLable.text = title
        self.contentLabel?.text = message
        self.cancelButton.setTitle(cancelButtonTitle, for: UIControl.State())
        self.confirmButton.setTitle(confirmButtonTitle, for: UIControl.State())
    }

    /*
     - 创建MessageDialog

     - para message: 消息文言
     */
    func createDialog(message: String) {
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        let sizeHeigth = (message.ga_heightForComment(fontSize: 17, width: SCREEN_WIDTH - 60-48)+130)>200 ?
            message.ga_heightForComment(fontSize: 17, width: SCREEN_WIDTH - 60-48)+130 : 200
        //白底
        bgView.frame = CGRect(x: 30,
                              y: SCREEN_HEIGHT / 2 - 100,
                              width: SCREEN_WIDTH - 60,
                              height: SCREEN_HEIGHT - sizeHeigth < 40 ? SCREEN_HEIGHT - 40 : sizeHeigth)
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 9
        bgView.clipsToBounds = true
        bgView.center = self.center

        self.addSubview(bgView)
        let width = bgView.frame.size.width
        let height = bgView.frame.size.height
    
        //标题
        titleLable.frame = CGRect(x: 0, y: 15, width: width, height: 25)
        titleLable.textColor = UIColor.black
        titleLable.font = UIFont.systemFont(ofSize: 19)
        titleLable.textAlignment = .center
        bgView.addSubview(titleLable)

        //滑动scroll
        scrollView.frame = CGRect(x: 24, y: 55, width: width - 48, height: height - 130)
        scrollView.isScrollEnabled = SCREEN_HEIGHT-bgView.frame.size.height == 40 ? true: false
        scrollView.contentSize = CGSize .init(width:0,
                                              height: message.ga_heightForComment(fontSize: 17,
                                                                                  width: SCREEN_WIDTH - 60-48))
        bgView.addSubview(scrollView)

        //内容
        contentLabel?.frame = CGRect(x: 0,
                                     y: 0,
                                     width: width - 48,
                                     height:message.ga_heightForComment(fontSize: 17, width: SCREEN_WIDTH - 60-48))
        contentLabel?.numberOfLines = 0
        contentLabel?.textAlignment = .center
        contentLabel?.textColor = UIColor.black
        contentLabel?.font = UIFont.systemFont(ofSize: 17)
        scrollView.addSubview(contentLabel!)

        //取消按钮
        let btnWith = (width - 30) / 2
        cancelButton.frame = CGRect(x: 10, y: height-10-45, width: btnWith, height: 45)
        cancelButton.backgroundColor = UIColor.gray
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        cancelButton.layer.cornerRadius = 3
        cancelButton.clipsToBounds = true
        cancelButton.tag = 1
        cancelButton.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(cancelButton)

        //确认按钮
        confirmButton.frame = CGRect(x: btnWith + 20 , y: height-10-45, width: btnWith, height: 45)
        confirmButton.backgroundColor = UIColor.red
        confirmButton.setTitleColor(UIColor.white, for: UIControl.State())
        confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        confirmButton.layer.cornerRadius = 3
        confirmButton.clipsToBounds = true
        confirmButton.tag = 2
        confirmButton.addTarget(self, action: #selector(clickBtnAction(_:)), for: .touchUpInside)
        bgView.addSubview(confirmButton)
    }
    
    // MARK: 按键的对应的方法
    @objc func clickBtnAction(_ sender: UIButton) {
        if (clickClosure != nil) {
            clickClosure!(sender.tag)
        }
        dismiss()
    }

    // MARK: 消失
    func dismiss() {
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.bgView.alpha = 0
            self.alpha = 0
        }, completion: { (finish) -> Void in
            if finish {
                self.removeFromSuperview()
            }
        })
    }

    /** 指定视图实现方法 */
    func show() {
        let wind = UIApplication.shared.keyWindow
        self.alpha = 0
        
        wind?.addSubview(self)
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            self.alpha = 1
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

