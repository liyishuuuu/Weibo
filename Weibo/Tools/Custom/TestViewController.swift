//
//  ViewController.swift
//  TestViewController
//
//  Created by liyishu on 2018/2/8.
//  Copyright © 2018年 Apple. All rights reserved.
//
import UIKit

class TestViewController: UIViewController {
    
    /** 懒加载*/
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
}
extension TestViewController {
    
    func setupUI(){
        view.addSubview(tableView)
        tableView.frame = CGRect .init(x: 0, y: 64, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        tableView.delegate = self
        tableView.dataSource = self
    }
}
extension TestViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cellID"
        // 这个cell是可选类型 因为通过一个ID可能取出来cell 也可能取不出来，取不出来的时候返回nil，取出来的时候返回一个cell
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID) //这里不能用let来修饰 因为如果取不出来数据的时候会返回nil，nil的地址为0x0， 但是通过下面的方法来创建一个cell并赋值给变量cell的时候，cell的地址会改变，所以不能用let
        
        if cell == nil {
            //枚举类型的使用方法： 1.枚举类型.具体的类型  2. 直接就是 .具体的类型
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        
        // 给cell设置数据
        // ?的作用可以联系上次学的 ？会先对前面的可选类型进行判断，如果可选类型没有值，则就不会执行后面的代码 如果有值 系统会自动解包
        cell?.textLabel?.text = "测试数据\(indexPath.row)"
        
        // 这里直接retrun cell的话会报错 因为我们返回的数据类型应该是UITableViewCell类型 这里的cell是可选类型 所以要对cell进行强制解包 这里的cell一定会有值，所以可以进行强制解包
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)")
        
        let messageDialog = MessageDialog(title: "提示", message: "登录成功", cancelButtonTitle: "取 消", confirmButtonTitle: "确 定")
        messageDialog.show()
        //获取点击事件
        messageDialog.clickIndexClosure { (index) in
            print("点击了第" + "\(index)" + "个按钮")
        }
    }
}
