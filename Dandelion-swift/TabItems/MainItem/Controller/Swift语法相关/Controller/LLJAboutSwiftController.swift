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
    
    typealias boclk = ((String, String) -> Void)
    
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
        //闭包相关
        block()
        //NSString 类簇 及 深拷贝浅拷贝
        stringAndCopy()
    }
}

//MARK - 闭包相关 -
extension LLJAboutSwiftController {
    
    func block() {
        
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


//MARK - NSString 类簇 及 深拷贝浅拷贝 -
extension LLJAboutSwiftController {
    
    func stringAndCopy() {
        
        self.view.backgroundColor = LLJWhiteColor()
        
        
    }
}


//MARK - guard判断语句 不符合条件执行else 符合条件继续执行 -
extension LLJAboutSwiftController {
    
    func showName(name: String?) {
       guard let name = name else {
        print("name==nil")
        return
        
        }
       print("my name is \(name)")
    }
}


//MARK - forEach 简化版for循环 -
extension LLJAboutSwiftController {
    
    func forEach1() {
        
        for view in self.view.subviews {
            if view is UIButton {
                let _: UIButton = view as! UIButton
            }
        }
    }
    
    func forEach2() {
        
        self.view.subviews.forEach { (view) in
            let _: UIButton = view as! UIButton
        }
    }
}


//MARK - //swift自动为闭包提供参数名缩写功能，可以直接通过$0和$1等来表示闭包中的第一个第二个参数 -
extension LLJAboutSwiftController {
    //删除所有子视图
    func removeSubView() {
        self.view.subviews.forEach {$0.removeFromSuperview()}
    }
}


/*  Swift中struct和class有什么不一样的地方？首先要先和大家提到一个观念，值类型ValueType和引用类型ReferenceType。其中

    struct是ValueType而class是ReferenceType。

    值类型的变量直接包含他们的数据，而引用类型的变量存储对他们的数据引用，因此后者称为对象，因此对一个变量操作可能影响另一个变量所引用的对象。对于值类型都有他们自己的数据副本，因此对一个变量操作不可能影响另一个变量。

    定义一个struct
    struct SRectangle {
     var width = 200
    }
 
    定义一个class
    class CRectangle {
     var width = 200
    }
 
    1. 成员变量
    struct SRectangle {
        var width = 200
        var height: Int
    }
    class CRectangle {
        var width = 200
        var height: Int // 报错
    }
    解释:
    struct定义结构体类型时其成员可以没有初始值，如果使用这种格式定义一个类，编译器是会报错的，他会提醒你这个类没有被初始化。

    2. 构造器

    var sRect = SRectangle(width: 300)
    sRect.width // 结果是300
    var cRect = CRectangle()
    // 不能直接用CRectangle(width: 300)，需要构造方法
    cRect.width // 结果是200
    解释:
    所有的struct都有一个自动生成的成员构造器，而class需要自己生成。

    3. 指定给另一个变量的行为不同

    var sRect2 = sRect
    sRect2.width = 500
    sRect.width // 结果是300
    var cRect2 = cRect
    cRect2.width = 500
    cRect.width // 结果是500
    解释：
    ValueType每一个实例都有一份属于自己的数据，在复制时修改一个实例的数据并不影响副本的数据。而ReferenceType被复制的时候其实复制的是一份引用，两份引用指向同一个对象，所以在修改一个实例的数据时副本的数据也被修改了。

    4. 不可变实例的不同

    let sRect3 = SRectangle(width: 300);
    sRect3.width = 500 // 报错
    let cRect3 = CRectangle()
    cRect3.width = 500
    解释:
    struct对于let声明的实例不能对变量进行赋值，class预设值是可以赋值let实例的。注意Swift中常用的String、Array、 Dictionary都是struct。

    方法

    struct SRectangle {
        var width = 200
        mutating func changeWidth(width: Int) {
            self.width = width
        }
    }
    class CRectangle {
        var width = 200
        func changeWidth(width: Int) {
            self.width = width
        }
    }
    解释:
    struct的方法要去修改property的值，要加上mutating，class则不需要。

    继承

    struct不能继承，class可以继承
 */
