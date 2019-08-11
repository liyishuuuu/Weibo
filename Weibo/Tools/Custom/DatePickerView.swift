//
//  DatePickerView.swift
//  SwiftUI
//
//  Created by liyishu on 2019/8/11.
//  Copyright © 2019 liyishu. All rights reserved.
//

import Foundation
import UIKit

private extension Selector {
    static let buttonTapped = #selector(DatePickerView.buttonTapped)
    static let deviceOrientationDidChange = #selector(DatePickerView.deviceOrientationDidChange)
}

open class DatePickerView: UIView {
    public typealias DatePickerCallback = ( Date? ) -> Void

    // MARK: - Constants

    /** 默认按钮高 */
    private let defaultButtonHeight: CGFloat = 50
    /** 默认按钮间距 */
    private let defaultButtonSpacerHeight: CGFloat = 1
    /** 按钮圆角 */
    private let cornerRadiu: CGFloat = 7
    /** Tag */
    private let comfirmButtonTag: Int = 1
    /** 日期选择器宽度 */
    private let datePickerWidth: CGFloat = 300
    /** 日期选择器高度 */
    private let dataPickerHeight: CGFloat = 216
    /** 标题宽度 */
    private let titleLabelWidth: CGFloat = 280
    /** 标题高度 */
    private let titleLabelHeight: CGFloat = 30
    /** 标题字体 */
    private let titleFont: CGFloat = 17
    /** 按钮字体 */
    private let buttonFont: CGFloat = 17

    // MARK: - Views

    /** 弹框 */
    private var dialogView: UIView!
    /** 标题 */
    private var titleLabel: UILabel!
    /** 日期选择 */
    open var datePicker: UIDatePicker!
    /** 取消按钮 */
    private var cancelButton: UIButton!
    /** 确认按钮 */
    private var comfirmButton: UIButton!

    // MARK: - 变量

    /** 默认日期 */
    private var defaultDate: Date?
    /** 日期选择模式 */
    private var datePickerMode: UIDatePicker.Mode?
    /** 回调 */
    private var callback: DatePickerCallback?
    /** 显示取消按钮 */
    var showCancelButton: Bool = false
    /** 位置 */
    var locale: Locale?
    /** 文字颜色 */
    private var textColor: UIColor!
    /** 按钮颜色 */
    private var buttonColor: UIColor!
    /** 字体 */
    private var font: UIFont!

    // MARK: - 初始化

     public init(textColor: UIColor = UIColor.black,
                      buttonColor: UIColor = UIColor.black,
                      font: UIFont = .boldSystemFont(ofSize: 15),
                      locale: Locale? = nil,
                      showCancelButton: Bool = true) {
        let size = UIScreen.main.bounds.size
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.textColor = textColor
        self.buttonColor = buttonColor
        self.font = font
        self.showCancelButton = showCancelButton
        self.locale = locale
        setupView()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 设备方向发生变化
    @objc func deviceOrientationDidChange(_ notification: Notification) {
        self.frame = UIScreen.main.bounds
        let dialogSize = CGSize(width: datePickerWidth, height: 230 + defaultButtonHeight + defaultButtonSpacerHeight)
        dialogView.frame = CGRect(
            x: (UIScreen.main.bounds.size.width - dialogSize.width) / 2,
            y: (UIScreen.main.bounds.size.height - dialogSize.height) / 2,
            width: dialogSize.width,
            height: dialogSize.height
        )
    }

    /// 创建弹框，添加打开动画
    open func show(_ title: String,
                   comfirmButtonTitle: String = "确定",
                   cancelButtonTitle: String = "取消",
                   defaultDate: Date = Date(),
                   minimumDate: Date? = nil,
                   maximumDate: Date? = nil,
                   datePickerMode: UIDatePicker.Mode = .dateAndTime,
                   callback: @escaping DatePickerCallback) {
        self.titleLabel.text = title
        self.comfirmButton.setTitle(comfirmButtonTitle, for: .normal)
        if showCancelButton {
            self.cancelButton.setTitle(cancelButtonTitle, for: .normal)
        }
        self.datePickerMode = datePickerMode
        self.callback = callback
        self.defaultDate = defaultDate
        self.datePicker.datePickerMode = self.datePickerMode ?? UIDatePicker.Mode.date
        self.datePicker.date = self.defaultDate ?? Date()
        self.datePicker.maximumDate = maximumDate
        self.datePicker.minimumDate = minimumDate
        if let locale = self.locale { self.datePicker.locale = locale }

        // 添加弹框
        guard let appDelegate = UIApplication.shared.delegate else { fatalError() }
        guard let window = appDelegate.window else { fatalError() }
        window?.addSubview(self)
        window?.bringSubviewToFront(self)
        window?.endEditing(true)
        
        NotificationCenter.default.addObserver(self,
                                               selector: .deviceOrientationDidChange,
                                               name: UIDevice.orientationDidChangeNotification, object: nil)

        // 动画
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
                self.dialogView?.layer.opacity = 1
                self.dialogView?.layer.transform = CATransform3DMakeScale(1, 1, 1)
        })
    }

    // MARK: - private method

    // 关闭
    private func close() {
        let currentTransform = self.dialogView.layer.transform
        let startRotation = (self.value(forKeyPath: "layer.transform.rotation.z") as? NSNumber) as? Double ?? 0.0
        let rotation = CATransform3DMakeRotation((CGFloat)(-startRotation + .pi * 270 / 180), 0, 0, 0)
        self.dialogView.layer.transform = CATransform3DConcat(rotation, CATransform3DMakeScale(1, 1, 1))
        self.dialogView.layer.opacity = 1
        UIView.animate(withDuration: 0.2,
                       delay: 0,
                       options: [],
                       animations: {
                        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
                        let transform = CATransform3DConcat(currentTransform, CATransform3DMakeScale(0.6, 0.6, 1))
                        self.dialogView.layer.transform = transform
                        self.dialogView.layer.opacity = 0
        }) { _ in
            for v in self.subviews {
                v.removeFromSuperview()
            }
            self.removeFromSuperview()
            self.setupView()
        }
    }

    // 设置View
    private func setupView() {
        dialogView = createContainerView()
        dialogView?.layer.shouldRasterize = true
        dialogView?.layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        dialogView?.layer.opacity = 0.5
        dialogView?.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1)
        backgroundColor = UIColor.init(hexString: "#000000")
        if let dialogView = dialogView {
            addSubview(dialogView)
        }
    }

    // 创建弹框，添加自定义内容和按钮
    private func createContainerView() -> UIView {
        let screenSize = UIScreen.main.bounds.size
        let dialogSize = CGSize(width: datePickerWidth, height: 230 + defaultButtonHeight + defaultButtonSpacerHeight)

        // 黑色背景
        self.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)

        // 弹框
        let dataPickerView = UIView(frame: CGRect(x: (screenSize.width - dialogSize.width) / 2,
                                                  y: (screenSize.height - dialogSize.height) / 2,
                                                  width: dialogSize.width,
                                                  height: dialogSize.height))
        let gradient: CAGradientLayer = CAGradientLayer(layer: self.layer)
        gradient.frame = dataPickerView.bounds
        gradient.colors = [
            UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor,
            UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1).cgColor,
            UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1).cgColor
        ]
        let cornerRadius = cornerRadiu
        gradient.cornerRadius = cornerRadius
        dataPickerView.layer.insertSublayer(gradient, at: 0)
        dataPickerView.layer.cornerRadius = cornerRadius
        dataPickerView.layer.borderColor = UIColor.init(hexString: "C6C6C6")?.cgColor
        dataPickerView.layer.borderWidth = 1
        dataPickerView.layer.shadowRadius = cornerRadius + 5
        dataPickerView.layer.shadowOpacity = 0.1
        dataPickerView.layer.shadowOffset = CGSize(width: 0 - (cornerRadius + 5) / 2, height: 0 - (cornerRadius + 5) / 2)
        dataPickerView.layer.shadowColor = UIColor.black.cgColor
        dataPickerView.layer.shadowPath = UIBezierPath(roundedRect: dataPickerView.bounds,
                                                       cornerRadius: dataPickerView.layer.cornerRadius).cgPath

        // 分割线
        let yPosition = dataPickerView.bounds.size.height - defaultButtonHeight - defaultButtonSpacerHeight
        let lineView = UIView(frame: CGRect(x: 0,
                                            y: yPosition,
                                            width: dataPickerView.bounds.size.width,
                                            height: defaultButtonSpacerHeight))
        lineView.backgroundColor = UIColor.init(hexString: "#DCDCDC")
        dataPickerView.addSubview(lineView)

        // 标题
        self.titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: titleLabelWidth, height: titleLabelHeight))
        self.titleLabel.textAlignment = .center
        self.titleLabel.textColor = self.textColor
        self.titleLabel.font = self.font.withSize(titleFont)
        dataPickerView.addSubview(self.titleLabel)
        self.datePicker = configuredDatePicker()
        dataPickerView.addSubview(self.datePicker)

        // 添加按钮
        addButtonsToView(container: dataPickerView)
        return dataPickerView
    }

    fileprivate func configuredDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 30, width: 0, height: 0))
        datePicker.setValue(self.textColor, forKeyPath: "textColor")
        datePicker.autoresizingMask = .flexibleRightMargin
        datePicker.frame.size.width = datePickerWidth
        datePicker.frame.size.height = dataPickerHeight
        return datePicker
    }

    // 向日期选择器中添加按钮
    private func addButtonsToView(container: UIView) {
        var buttonWidth = container.bounds.size.width / 2
        var leftButtonFrame = CGRect(x: 0,
                                     y: container.bounds.size.height - defaultButtonHeight,
                                     width: buttonWidth,
                                     height: defaultButtonHeight)
        var rightButtonFrame = CGRect(x: buttonWidth,
                                      y: container.bounds.size.height - defaultButtonHeight,
                                      width: buttonWidth,
                                      height: defaultButtonHeight)
        if showCancelButton == false {
            buttonWidth = container.bounds.size.width
            leftButtonFrame = CGRect()
            rightButtonFrame = CGRect(x: 0,
                                      y: container.bounds.size.height - defaultButtonHeight,
                                      width: buttonWidth,
                                      height: defaultButtonHeight)
        }
        let interfaceLayoutDirection = UIApplication.shared.userInterfaceLayoutDirection
        let isLeftToRightDirection = interfaceLayoutDirection == .leftToRight

        // 显示取消按钮
        if showCancelButton {
            self.cancelButton = UIButton(type: .custom) as UIButton
            self.cancelButton.frame = isLeftToRightDirection ? leftButtonFrame : rightButtonFrame
            self.cancelButton.setTitleColor(self.buttonColor, for: .normal)
            self.cancelButton.setTitleColor(self.buttonColor, for: .highlighted)
            self.cancelButton.titleLabel?.font = self.font.withSize(buttonFont)
            self.cancelButton.layer.cornerRadius = cornerRadiu
            self.cancelButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            container.addSubview(self.cancelButton)
        }

        // 确认按钮
        self.comfirmButton = UIButton(type: .custom) as UIButton
        self.comfirmButton.frame = isLeftToRightDirection ? rightButtonFrame : leftButtonFrame
        self.comfirmButton.tag = comfirmButtonTag
        self.comfirmButton.setTitleColor(self.buttonColor, for: .normal)
        self.comfirmButton.setTitleColor(self.buttonColor, for: .highlighted)
        self.comfirmButton.titleLabel?.font = self.font.withSize(buttonFont)
        self.comfirmButton.layer.cornerRadius = cornerRadiu
        self.comfirmButton.addTarget(self, action: .buttonTapped, for: .touchUpInside)
        container.addSubview(self.comfirmButton)
    }

    @objc func buttonTapped(sender: UIButton) {
        if sender.tag == comfirmButtonTag {
            self.callback?(self.datePicker.date)
        } else {
            self.callback?(nil)
        }
        close()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
