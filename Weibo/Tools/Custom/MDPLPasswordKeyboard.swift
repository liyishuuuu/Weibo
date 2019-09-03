//
//  WBPasswordKeyboard.swift
//  Weibo
//
//  Created by liyishu on 2019/9/3.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

// 屏幕的宽度
let deviceScreenWith = UIScreen.main.bounds.size.width

class MDPLPasswordKeyboard: UIInputView,
                            UITextFieldDelegate,
                            UIGestureRecognizerDelegate {

    // MARK: - 属性

    /** 文本输入框 */
    private var textFields = [UITextField]()

    /** 父视图 */
    private var superView: UIView?

    /** 按钮的个数 */
    private let buttonsCount: Int = 12

    /** 按钮数组 */
    private var buttions = [UIButton]()

    /** 是否高亮 */
    public var withHighlight = false {
        didSet {
            highlightButton(withHighlight: withHighlight)
        }
    }

    /** 是否开启键盘 */
    public var isEnableKeyboard: Bool = false {
        didSet {
            if isEnableKeyboard {
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(keyboardWillShow(_:)),
                                                       name: UIResponder.keyboardWillShowNotification,
                                                       object: nil)
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(keyboardWillHide(_:)),
                                                       name: UIResponder.keyboardWillHideNotification,
                                                       object: nil)
            } else {
                NotificationCenter.default.removeObserver(self)
            }
        }
    }

    // MARK: - 方法

    /**
     初始化方法
     
     - Parameter view: 视图
     - Parameter field: 文本输入框
     */
    public convenience init(_ view: UIView, field: UITextField? = nil) {
        self.init(frame: CGRect.zero, inputViewStyle: .keyboard)
        backgroundColor = .white
        addKeyboard(view, field: field)
    }

    /**
     初始化方法
     
     - Parameter frame: 尺寸
     - Parameter inputViewStyle: 输入视图样式
     */
    public override init(frame: CGRect, inputViewStyle: UIInputView.Style) {
        super.init(frame: frame, inputViewStyle: inputViewStyle)
        self.frame.size.height = 240
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // 布局视图的时候调用
    override func layoutSubviews() {
        super.layoutSubviews()

        // 列数
        let columnsNum = 3

        // 行数
        let lineNum = 4

        /// 一个按钮的宽度
        let btnWidth = frame.width / CGFloat(columnsNum)

        /// 一个按钮的高度
        let btnHeight = frame.height / CGFloat(lineNum)

        // 循环布局12个按钮
        for i in 0...11 {
            let view = viewWithTag(i + 1)
            view?.frame.origin.x = btnWidth * CGFloat((i) % 3)  //3个按钮以换行
            view?.frame.origin.y = btnHeight * CGFloat((i) / 3)
            view?.frame.size.width = btnWidth
            view?.frame.size.height = btnHeight
        }
    }

    /**
     绘制界面
     
     - Parameter rect: 绘图
     */
    override func draw(_ rect: CGRect) {

        // 列数
        let columnsNum = 3

        // 行数
        let lineNum = 4

        // 一个按钮的宽度
        let btnWidth = frame.width / CGFloat(columnsNum)

        // 一个按钮的高度
        let btnHeight = frame.height / CGFloat(lineNum)

        // 创建一个贝塞尔路径
        let bezierPath = UIBezierPath()

        // 4条横线
        for i in 0...lineNum - 1 {

            //开始绘制
            bezierPath.move(to: CGPoint(x: 0, y: btnHeight * CGFloat(i)))
            bezierPath.addLine(to: CGPoint(x: frame.width, y: btnHeight * CGFloat(i)))
        }

        // 2条竖线
        for i in 1...columnsNum - 1 {
            bezierPath.move(to: CGPoint(x: btnWidth * CGFloat(i), y: 0))
            bezierPath.addLine(to: CGPoint(x: btnWidth * CGFloat(i), y: frame.height))
        }
        UIColor.lightGray.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
    }

    // MARK: - private method

    /**
     添加键盘视图
     
     - Parameter view: 视图
     - Parameter field: 文本输入框
     */
    private func addKeyboard(_ view: UIView, field: UITextField? = nil) {
        superView = view
        customSubview()
        guard let textField = field else {
            for view in (superView?.subviews)! {
                guard view.isKind(of: UITextField.self) else { return }
                let textField = view as! UITextField
                textField.delegate = self
                textField.inputView = self
                textFields.append(textField)
            }
            return
        }
        textFields.append(textField)
        textField.inputView = self
        textField.delegate = self
    }

    /**
     自定义视图
     */
    private func customSubview() {

        // 设置图片
        let backSpace = UIImage(named: "Keyboard_Backspace")
        
        // 创建键盘视图上所有的按钮
        for index in 0 ..< buttonsCount {
            let button = UIButton()
            button.titleLabel?.font = UIFont.systemFont(ofSize: 28)
            button.setTitleColor(UIColor.black, for: .normal)

            // tag值(从0开始)
            switch index {

            // .
            case 9:
                button.setTitle(".", for: .normal)
                button.backgroundColor = .lightGray

            // 0
            case 10:
                button.setTitle("0", for: .normal)
                buttions.append(button)

            // x
            case 11:
                button.setTitle("", for: .normal)
                button.setImage(backSpace, for: .normal)
                button.backgroundColor = .lightGray

            // 数字
            default:
                button.setTitle("\(index + 1)", for: .normal)
                buttions.append(button)
            }
            button.addTarget(self, action: #selector(clickAction), for: .touchUpInside)
            addSubview(button)
            button.tag = index + 1
        }
    }
    
    /**
     检查小数点

     - Parameter button: 按钮
     */
    private func checkPoint(button: UIButton) {
        
        // 获取按钮的当前文字
        guard let text = button.currentTitle else {
            return
        }
        
        // 获取文本输入框的文字
        guard let str = firstResponder()?.text else {
            return
        }

        // 是否包含字符 '.'
        let subStr = str.contains(".")

        if subStr {
            print("小数点已存在....")
        } else {
            firstResponder()?.insertText(text)
        }
    }

    /**
     处理删除
     
     - Parameter button: 按钮
     */
    private func deleteAction(button: UIButton) {
        
        // 单击删除
        firstResponder()?.deleteBackward()
        
        /// 创建长按手势
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(deleteLongPressed))
        longPress.delegate = self
        
        // 设置最低长按时长(以秒为单位)
        longPress.minimumPressDuration = 0.5
        
        // 添加长按手势
        button.addGestureRecognizer(longPress)
    }

    /**
     高亮状态
     
     - Parameter heghlight: 是否高亮
     */
    private func highlightButton(withHighlight: Bool) {
        
        print(subviews.count)
        
        // 获取当前视图的所有子视图的个数
        let subviewCount = subviews.count
        
        // 获取当前视图的所有按钮的个数
        let subviewBtnCout = subviewCount
        
        for i in 0...subviewBtnCout {
    
            // 获取按钮
            guard let button = subviews[i] as? UIButton else {
                return
            }
            if withHighlight {
                button.setBackgroundImage(UIImage(named: ""), for: .normal)
                button.setBackgroundImage(UIImage(named: ""), for: .highlighted)
            } else {
                button.setBackgroundImage(UIImage(named: ""), for: .normal)
                button.setBackgroundImage(UIImage(named: ""), for: .highlighted)
            }
        }
    }
    
    /**
     第一响应者
     
     - Returns: 文本输入框
     */
    private func firstResponder() -> UITextField? {
        var firstResponder: UITextField?
        for field in textFields {
            if field.isFirstResponder {
                firstResponder = field
            }
        }
        return firstResponder
    }

    /**
     键盘视图按钮点击事件
     
     - Parameter sender: 按钮
     */
    @objc func clickAction(_ sender: UIButton) {
        
        // 获取按钮的当前文字
        guard let text = sender.currentTitle else {
            return
        }

        // 因为上文button的tag值加1, 所以值改变了
        switch sender.tag {

        // (9+1).
        case 10:
            checkPoint(button: sender)

        // (11+1)x
        case 12:
            deleteAction(button: sender)

        // 数字
        default:
            firstResponder()?.insertText(text)
        }
    }

    /**
     删除按钮长按事件
     
     - Parameter sender: 长按手势
     */
    @objc private func deleteLongPressed(_ sender: UILongPressGestureRecognizer) {
        
        guard sender.state == .began else {
            print("长按响应结束")
            return
        }
        print("长按响应开始")
        
        // 根据文本输入框的文字的个数, 多次循环删除
        for _ in 0...(firstResponder()?.text?.count)! {
            firstResponder()?.deleteBackward()
        }
    }

    /**
     键盘即将显示 (弹起)
     
     - Parameter notification: 通知
     */
    @objc private func keyboardWillShow(_ notification: NSNotification) {
    }

    /**
     键盘即将隐藏 (收起)
     
     - Parameter notification: 通知
     */
    @objc private func keyboardWillHide(_ notification: NSNotification) {
    }
}
