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
     * rect.w = rect.h 时画圆； rect.w != rect.h 画椭圆
     */
    class func drawCyle(arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) -> UIBezierPath {
        
        let path = UIBezierPath.init(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
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
    
}
