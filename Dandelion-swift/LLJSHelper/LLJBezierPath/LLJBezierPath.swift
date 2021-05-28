//
//  LLJBezierPath.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/16.
//

import UIKit

class LLJBezierPath {

    /*
     * 画圆 椭圆
     * rect.w = rect.h 时画圆； rect.w != rect.h 画椭圆
     */
    class func drawCyle(rect: CGRect) -> UIBezierPath {
        
        let path = UIBezierPath.init(ovalIn: rect)
        return path
    }
    
    /*
     * 画圆 圆弧
     * arcCenter: 圆心
     * radius: 半径
     * startAngle: 开始角度
     * endAngle: 结束角度
     * clockwise: 顺时针 yes 逆时针 no
     */
    class func drawCyle(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> UIBezierPath {
        
        let path = UIBezierPath.init(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        return path
    }
    
    /*
     * 画矩形 统一圆角
     * rect: 矩形rect
     */
    class func drawRoundedRect(rect: CGRect, cornerRadius: CGFloat?) -> UIBezierPath {
        
        let path = UIBezierPath.init(roundedRect: rect, cornerRadius: cornerRadius ?? 0.0)
        return path
    }
    
    /*
     * 画矩形 单一圆角
     * rect: 矩形rect
     */
    class func drawRoundedRect(rect: CGRect, byRoundingCorners: UIRectCorner, cornerRadius: CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        return path
    }
    
    /*
     * 画矩形 可变圆角
     * byRoundingCorners: 需要切的圆角
     * cornerRadius: 圆角半径
     * 注意：byRoundingCorners要和cornerRadius一一对应。
     * 如：[UIRectCorner.topLeft,UIRectCorner.topRight,UIRectCorner.bottomLeft,UIRectCorner.bottomRight] 对应 [10,5,5,10]
     */
    class func drawRoundedRect(rect: CGRect, byRoundingCorners: [UIRectCorner], cornerRadius: [CGFloat]) -> UIBezierPath {
        
        let path = UIBezierPath()
        let startPoint = CGPoint(x: rect.origin.x, y: rect.origin.y)
        
        //处理第一个角
        if byRoundingCorners.contains(UIRectCorner.topLeft) {
            
            let position = byRoundingCorners.firstIndex(of: UIRectCorner.topLeft)
            path.move(to: CGPoint(x: startPoint.x + cornerRadius[position!], y: startPoint.y))
        } else {
            path.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        }
        //处理第二个角
        if byRoundingCorners.contains(UIRectCorner.topRight) {
            
            let position = byRoundingCorners.firstIndex(of: UIRectCorner.topRight)
            path.addLine(to: CGPoint(x: startPoint.x + rect.width - cornerRadius[position!], y: startPoint.y))
            path.addArc(withCenter: CGPoint(x: startPoint.x + rect.width - cornerRadius[position!], y: startPoint.y + cornerRadius[position!]), radius: cornerRadius[position!], startAngle: CGFloat.pi*3/2, endAngle: 0, clockwise: true)
            
        } else {
            path.addLine(to: CGPoint(x: startPoint.x + rect.width, y: startPoint.y))
        }
        //处理第三个角
        if byRoundingCorners.contains(UIRectCorner.bottomRight) {
            
            let position = byRoundingCorners.firstIndex(of: UIRectCorner.bottomRight)
            path.addLine(to: CGPoint(x: startPoint.x + rect.width, y: startPoint.y + rect.height - cornerRadius[position!]))
            path.addArc(withCenter: CGPoint(x: startPoint.x + rect.width - cornerRadius[position!], y: startPoint.y + rect.height - cornerRadius[position!]), radius: cornerRadius[position!], startAngle: 0, endAngle: CGFloat.pi/2, clockwise: true)
            
        } else {
            path.addLine(to: CGPoint(x: startPoint.x + rect.width, y: startPoint.y + rect.height))
        }
        
        //处理第四个角
        if byRoundingCorners.contains(UIRectCorner.bottomLeft) {
            
            let position = byRoundingCorners.firstIndex(of: UIRectCorner.bottomLeft)
            path.addLine(to: CGPoint(x: startPoint.x + cornerRadius[position!], y: startPoint.y + rect.height))
            path.addArc(withCenter: CGPoint(x: startPoint.x + cornerRadius[position!], y: startPoint.y + rect.height - cornerRadius[position!]), radius: cornerRadius[position!], startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true)

        } else {
            path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y + rect.height))
        }
        
        //再次处理第一个角
        if byRoundingCorners.contains(UIRectCorner.topLeft) {
            
            let position = byRoundingCorners.firstIndex(of: UIRectCorner.topLeft)
            path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y + cornerRadius[position!]))
            path.addArc(withCenter: CGPoint(x: startPoint.x + cornerRadius[position!], y: startPoint.y + cornerRadius[position!]), radius: cornerRadius[position!], startAngle: CGFloat.pi, endAngle: CGFloat.pi*3/2, clockwise: true)

        } else {
            path.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y))
        }
        
        return path
    }
    
    
    /*
     * 画多边行 或折线
     * pointArray：多边形顶点数组，第一个点默认起点
     * closePath：true表示关闭，即多边形；false表示不关闭，即折线图
     */
    class func drawPolygon(pointArray: Array<CGPoint>, closePath: Bool) -> UIBezierPath {
        
        let path = UIBezierPath()
        for i in stride(from: 0, to: pointArray.count, by: 1) {
            let point = pointArray[i]
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        if closePath {
            path.close()
        }
        
        return path
    }
    
    /*
     * 画曲线 单曲线
     * startPoint: 起点
     * endPoint: 终点
     * controlPoint: 控制点
     */
    class func drawoQuadCurve(startPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint) -> UIBezierPath {
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        return path
    }
    
    /*
     * 画曲线 双曲线
     * startPoint: 起点
     * endPoint: 终点
     * controlPoint1: 控制点1
     * controlPoint2: 控制点2
     */
    class func drawCurve(startPoint: CGPoint, endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) -> UIBezierPath {
        
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        return path
    }
    
}
