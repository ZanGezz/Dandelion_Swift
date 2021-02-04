//
//  LLJSHelper.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/13.
//

import UIKit

class LLJSHelper: NSObject {
    
    /**
     * 获取本地文件资源如txt等
     */
    class func getLocalSource(path : String) -> Any {
        let data = NSData.init(contentsOfFile: path)
        let json = try! JSONSerialization.jsonObject(with: data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers)
        return json as Any
    }
    /**
     * 创建本地文件夹路径
     */
    class func createLocalDirectoryPath(path : String) {
        if !FileManager.default.fileExists(atPath: path) {
            try! FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        }
    }
    /**
     * 创建本地文件路径
     */
    class func createLocalFilePath(path : String) -> Bool {
        if !FileManager.default.fileExists(atPath: path) {
            return FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }
        return true
    }
    /**
     * 颜色转图片
     */
    class func getImageByColorAndSize(_ color: UIColor, _ size: CGSize) -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.setStrokeColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    /**
     * 类名获取类
     */
    class func getClassFromString(_ classString: String) -> LLJFViewController {
        //拼接字符串className时 - 需替换为 _ 。
        let className = "Dandelion_swift" + "." + classString
        var anyClass: AnyClass? = NSClassFromString(className)
        if (anyClass == nil) {
            anyClass = NSClassFromString(classString)
        }
        let viewControllerClass = anyClass as! LLJFViewController.Type
        let viewController = viewControllerClass.init()
        return viewController
    }
}
