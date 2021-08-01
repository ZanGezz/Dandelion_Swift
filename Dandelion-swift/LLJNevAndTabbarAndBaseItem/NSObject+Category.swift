//
//  NSObject+Category.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/7/6.
//

import Foundation
import UIKit

extension UIViewController {
    
    //分类添加方法
    func addMethods() {
        LLJLog("addMethods")
    }
    //分类添加属性
    var addProperty: String {
        set {
            objc_setAssociatedObject(self, "addProperty", newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            objc_getAssociatedObject(self, "addProperty") as! String
        }
    }
    
    //获取方法列表
    func getMethodsList(instance: AnyClass) -> [String] {
        
        var nameArray: [String] = []
        var outCount: UInt32 = 0
        let methodList: UnsafeMutablePointer<Method> = class_copyMethodList(instance, &outCount)!
        
        let count: Int = Int(outCount)
        for i in stride(from: 0, to: count-1, by: 1){
            let method = methodList[i]
            let name: String = String(utf8String: property_getName(method))!
            nameArray.append(name)
        }
        return nameArray
    }
    
    //获取属性列表
    func getPropertyList(instance: AnyClass) -> [String] {
        var nameArray: [String] = []
        var outCount: UInt32 = 0
        let methodList: UnsafeMutablePointer<Ivar> = class_copyIvarList(instance, &outCount)!
        
        let count: Int = Int(outCount)
        for i in stride(from: 0, to: count-1, by: 1){
            let ivar = methodList[i]
            let name: String = String(utf8String: property_getName(ivar))!
            nameArray.append(name)
        }
        return nameArray
    }
}

extension UIView {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let keyBoardStatus = UserDefaults.standard.bool(forKey: "keyBoardStatus")
        if keyBoardStatus {
            UIApplication.shared.keyWindow?.endEditing(true)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}

extension UIButton {
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let keyBoardStatus = UserDefaults.standard.bool(forKey: "keyBoardStatus")
        if keyBoardStatus {
            UIApplication.shared.keyWindow?.endEditing(true)
        } else {
            super.touchesBegan(touches, with: event)
        }
    }
}
