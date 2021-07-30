//
//  LLJSHelper.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/13.
//

import UIKit

public class LLJSHelper {
    
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
    class func getClassFromString(_ classString: String) -> LLJFViewController? {
        //拼接字符串className时 - 需替换为 _ 。
        let className = "Dandelion_swift" + "." + classString
        let anyClass: AnyClass? = NSClassFromString(className)
        let viewControllerClass = anyClass as? LLJFViewController.Type
        // 如果不是 UIViewController类型,则renturn
        guard (viewControllerClass != nil) else{
            print("Can not append")
            return nil;
        }
        let viewController = viewControllerClass!.init()
        return viewController
    }
    
    /**
     * 生成随机数
     */
    class func arc4random(duration: Int) -> Int {
        return Int(Darwin.arc4random()) % duration
    }
    
    /**
     * 退出app
     */
    class func exitApplication() {
        
        let window = UIApplication.shared.keyWindow
        UIView.animate(withDuration: 0.35) {
            window!.alpha = 0
            window!.frame = CGRect(x: 0, y: window!.bounds.size.height / 2, width: window!.bounds.size.width, height: 0.5)
        } completion: { (finished) in
            exit(0)
        }

    }
    
    /**
     * 事件响应链查找view所在viewController
     */
    class func getSuperViewController(_ subView: UIView) -> UIViewController? {
        var nextResponder :UIResponder? = subView.next
        while (nextResponder != nil) {
            if (nextResponder!.isKind(of: UIViewController.self)) {
                return (nextResponder as! UIViewController)
            }
            nextResponder = nextResponder?.next
        }
        return nil
    }
    
    /**
     * 根据角度获取圆周率
     */
    class func getPrintsByAngle(angle: Double) -> Double {
        return angle * Double.pi / 180.0
    }
    
    
    /**
     * 根据字体获取string的size
     */
    class func getStringSize(subString: String, font: UIFont, width: CGFloat) -> CGSize {
        
        return getStringSize(subString: subString, font: font, width: width, lineSpace: 0.0)
    }
    
    /**
     * 根据字体获取string的size 设置行间距
     */
//    class func getStringSize(subString: String, font: UIFont, width: CGFloat, lineSpace: CGFloat) -> CGSize {
//
//        let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
//        paragraphStyle.lineSpacing = lineSpace
//        let string: NSString = subString as NSString
//        var W = width
//        if  W <= 0.0 {
//            W = CGFloat(MAXFLOAT)
//        }
//        let size = string.boundingRect(with: CGSize(width: W, height: 0.0), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font,NSAttributedString.Key.paragraphStyle: paragraphStyle], context: nil).size
//        return size
//    }
    
    class func getStringSize(subString: String, font: UIFont, width: CGFloat, lineSpace: CGFloat) -> CGSize {
        let attritube = NSMutableAttributedString(string: subString)
        let range = NSRange(location: 0, length: attritube.length)
        attritube.addAttributes([NSAttributedString.Key.font: font], range: range)
        if lineSpace > 0.0 {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpace
            attritube.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
        }
        
        let rect = attritube.boundingRect(with: CGSize(width: width, height: 0.0), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        var size = rect.size
        
        // 文本的高度减去字体高度小于等于行间距，判断为当前只有1行
        let spacing = size.height - font.lineHeight
        if spacing <= lineSpace && spacing > 0 {
            size = CGSize(width: size.width, height: font.lineHeight)
        }
        
        return size
    }
    
    /**
     * 获取当前时间戳
     */
    class func getCurrentTimeInteval() -> Int64 {
        
        return Int64(NSDate().timeIntervalSince1970)
    }
    
    /**
     * 时间戳转化为分钟
     */
    class func exChangeTimeIntevalToMin(timeInteval: Int64) -> String {
        
        var min = "1秒前"
        var dt = getCurrentTimeInteval() - timeInteval
        if dt < 60 {
            min = String(dt) + "秒前"
        } else {
            dt = dt/60
            if dt < 60 {
                min = String(dt) + "分钟前"
            } else {
                dt = dt/60
                if dt < 24 {
                    min = String(dt) + "小时前"
                } else {
                    dt = dt/24
                    if dt < 30 {
                        min = String(dt) + "天前"
                    } else {
                        dt = dt/30
                        if dt < 12 {
                            min = String(dt) + "月前"
                        } else {
                            dt = dt/12
                            min = String(dt) + "年前"
                        }
                    }
                }
            }
        }
        
        return min
    }
}
