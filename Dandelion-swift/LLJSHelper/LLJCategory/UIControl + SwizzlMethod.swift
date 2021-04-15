//
//  UIControl + SwizzlMethod.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/3/25.
//

import Foundation
import UIKit

extension UIControl {
    
    class func swizzlAddTargetMethod(){

        let originalSelector = #selector(sendAction(_:to:for:))
        let swizzledSelector = #selector(llj_sendAction(_:to:for:))

        swizzlMethod(methodClass: UIControl.self, originalSelector: originalSelector, swizzledSelector: swizzledSelector)
    }

    class func swizzlMethod(methodClass: AnyClass, originalSelector: Selector, swizzledSelector: Selector) {

        let originalMethod = class_getInstanceMethod(methodClass, originalSelector)
        let swizzledMethod = class_getInstanceMethod(UIControl.self, swizzledSelector)

        //在进行 Swizzling 的时候,需要用 class_addMethod 先进行判断一下原有类中是否有要替换方法的实现
        let didAddMethod: Bool = class_addMethod(methodClass, originalSelector, method_getImplementation(swizzledMethod!), method_getTypeEncoding(swizzledMethod!))
        //如果 class_addMethod 返回 yes,说明当前类中没有要替换方法的实现,所以需要在父类中查找,这时候就用到 method_getImplemetation 去获取 class_getInstanceMethod 里面的方法实现,然后再进行 class_replaceMethod 来实现 Swizzing
        if didAddMethod {
            class_replaceMethod(UIControl.self, swizzledSelector, method_getImplementation(originalMethod!), method_getTypeEncoding(originalMethod!))
        } else {
            method_exchangeImplementations(originalMethod!, swizzledMethod!)
        }
    }

    @objc func llj_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        LLJLog("UIButton = " + ((self as! UIButton).titleLabel?.text ?? "没有名字"));
        self.llj_sendAction(action, to: target, for: event)
    }
}
