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

//MARK - swift 关键字 -
extension LLJAboutSwiftController {
    
    //let：声明静态变量，类似于const，用let声明的变量不可以再赋值，不然会报错

    //var：声明变量，是可以改变值

    //class：用来声明一个类

    //enum：用来声明一个枚举

    //func：用来定义函数

    //init：相对于类的构造方法的修饰

    //deinit：属于析构函数。析构函数(destructor) 与构造函数相反，当对象结束其生命周期时（例如对象所在的函数已调用完毕），系统自动执行析构函数

    //fileprivate: 权限在本文件可访问,一个文件可以定义多个类或结构体
    
    //private: 权限在该类或结构体可访问
    
    //guard: 判断语句 符合条件继续往下执行 不符合条件执行else 通常是return
    
    //where：用于条件判断,和数据库查询时的where 'id > 10'这样功能. swift语言的特性.OC中并没有
    
    //mutating：写在func前面,以便于让func可以修改struct和protocol的extension中的成员的值。 如果func前面不加mutating，struct和protocol的extension中的成员的值便被保护起来，不能修改
    
    //is：is一般用于对一些变量的类型做判断.类似于OC中的isKindClass. as 与强制转换含义雷同
    
    //as：keyword：Guaranteed conversion、 Upcasting 理解：字面理解就是有保证的转换，从派生类转换为基类的向上转型
    
    //as?: keyword：** Optional、 Nil***  Swfit代码写一段时间后会发现到处都是 ？，这预示着如果转换不成功的时候便会返回一个 nil 对象，成功的话返回可选类型值（optional）。
    
    //extension：扩展，类似于OC的categories，Swift 中的可以扩展以下几个：
    /*
     添加计算型属性和计算静态属性
     定义实例方法和类型方法
     提供新的构造器
     定义下标
     定义和使用新的嵌套类型
     使一个已有类型符合某个接口
     */

    //typealias：为此类型声明一个别名.和 typedef类似.

    //override：如果我们要重写某个方法, 或者某个属性的话, 我们需要在重写的变量前增加一个override关键字
    
    //subscript：下标索引修饰.可以让class、struct、以及enum使用下标访问内部的值
    
    //final：Swift中，final关键字可以在class、func和var前修饰。表示 不可重写，可以将类或者类中的部分实现保护起来,从而避免子类破坏
    
    //break：跳出循环.一般在控制流中使用,比如 for . while switch等语句

    //case：switch的选择分支.

    //continue: 跳过本次循环,继续执行后面的循环.

    //in：范围或集合操作,多用于遍历.

    //fallthrough： //swift语言特性switch语句的break可以忽略不写,满足条件时直接跳出循环
                    //.fallthrough的作用就是执行完当前case,继续执行下面的case
                    //.类似于其它语言中省去break里，会继续往后一个case跑，直到碰到break或default才完成的效果
    
    //dynamicType : 获取对象的动态类型，即运行时的实际类型，而非代码指定或编译器看到的类型
    
    //#column: 列号,

    //#file:路径,

    //#function: 函数,

    //#line : 行号
    
    //print("COLUMN = (#column) \n FILE = (#file) \n FUNCTION = (#function) \n LINE = (#line)")
  
    //convenience：convenience用来进行方便的初始化，就相当于构造函数重载。
    /*
     convenience init(name:String!,nikname:String!) {
        self.init()
        self.name = name
        self.nikname = nikname
     }
     */

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
