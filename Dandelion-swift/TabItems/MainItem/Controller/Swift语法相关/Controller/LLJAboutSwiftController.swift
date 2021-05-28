//
//  LLJAboutSwiftController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/5/21.
//

import UIKit

//MARK: - extension -
extension LLJAboutSwiftController {
    
    /*
     * 1. extension 不是创建属性，属性只能在class里创建。可以使用计算属性来关联属性(类似oc动态添加属性)
     */
}

class LLJAboutSwiftController: LLJFViewController {

    //MARK: - 闭包 -
    //创建别名闭包
    typealias supBlock = ((String, String) -> Void)

    //属性闭包
    var subBlock: supBlock?
    
    //给当前类声明一个闭包变量supBlock，将subBlock函数内的闭包参数赋值给这个变量，此时这个闭包就可以在函数执行结束后或其他时候被调用。
    //上述闭包即为逃逸闭包要用 @escaping 修饰
    func subBlock(block: @escaping supBlock) {
        self.subBlock = block
    }
    
    //给函数subBlock1传递一个闭包参数block。
    func subBlock1(block: (String, String) -> Void) {
        
        //此时闭包block调用只能在函数作执行结束前被当做函数内的任务依次被执行，这种情况下的闭包就是非逃逸闭包。
        block("str1","str2")
    }
    
    
    
    //MARK: - 属性 -
    //存储属性
    var name: String?
    var _age: String = "age"
    
    //计算属性
    //get
    var name1: String {
        get {
            return "str1"
        }
    }
    
    //get set
    //通常使用计算属性给存储属性赋值(类似oc重写属性get set方法)
    var age: String {
        
        set {
            _age = newValue
        }
        get {
            return _age
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
}

//MARK - 闭包相关 -
extension LLJAboutSwiftController {
    
    func setUpUI() {
        
        self.view.backgroundColor = LLJWhiteColor()
        
        self.subBlock = {(str1, str2) in
            LLJLog(str1 + "  1  " + str2)
        }
        
        if self.subBlock != nil {
            self.subBlock!("str1","str2")
        }
        
        self.subBlock { (str1, str2) in
            LLJLog(str1 + "  2  " + str2)
        }
        
        if self.subBlock != nil {
            self.subBlock!("str1","str2")
        }
        
        self.subBlock1 { (str1, str2) in
            LLJLog(str1 + "  3  " + str2)
        }
    }
}
