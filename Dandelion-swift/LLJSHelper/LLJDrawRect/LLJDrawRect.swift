//
//  LLJDrawRect.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/16.
//

import UIKit

class LLJDrawRect {

    /*
     * 画圆 椭圆
     * superView: 画图显示的试图
     * rect.w = rect.h 时画圆； rect.w != rect.h 画椭圆
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawCyle(rect: CGRect, lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {
        
        let path = LLJBezierPath.drawCyle(rect: rect)
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    /*
     * 画圆 圆环
     * superView: 画图显示的试图
     * arcCenter: 圆心; radius: 半径; startAngle: 开始角度; endAngle: 结束角度; clockwise: 顺时针还是逆时针;
     * lineWidth: 线宽; strokColor: 线颜色; fillColor: 填充颜色;
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawCyle(lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, backColor: UIColor?, arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool, lineDashPattern: [NSNumber]?, superLayer: CALayer, animation: CAAnimation?) {
        
        let path = LLJBezierPath.drawCyle(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    
    /*
     * 画矩形
     * rect：矩形rect
     * superView: 父试图
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawRoundedRect(rect: CGRect, lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {
        
        let path = LLJBezierPath.drawRoundedRect(rect: rect, cornerRadius: 0.0)
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    /*
     * 画矩形 切圆角
     * rect：矩形rect
     * superView: 父试图
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawRoundedRect(rect: CGRect, byRoundingCorners: [UIRectCorner], cornerRadius: [CGFloat], lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {
        
        let path = LLJBezierPath.drawRoundedRect(rect: rect, byRoundingCorners: byRoundingCorners,cornerRadius: cornerRadius)
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    
    /*
     * 画多边行 或折线
     * pointArray：多边形顶点数组，第一个点默认起点
     * closePath：true表示关闭，即多边形；false表示不关闭，即折线图
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawPolygon(pointArray: Array<CGPoint>, closePath: Bool, lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {
        
        let path = LLJBezierPath.drawPolygon(pointArray: pointArray, closePath: closePath)
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    
    /*
     * 画曲线 单曲线
     * startPoint: 起点
     * endPoint: 终点
     * controlPoint: 控制点
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawQuadCurve(startPoint: CGPoint, endPoint: CGPoint, controlPoint: CGPoint, lineWidth: CGFloat, strokColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {

        let path = LLJBezierPath.drawoQuadCurve(startPoint: startPoint, endPoint: endPoint, controlPoint: controlPoint)
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: nil, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    
    /*
     * 画曲线 双曲线      正弦曲线 y = a*sin(bx + c) + d
     * startPoint: 起点
     * endPoints: 终点集合
     * controlPoints: 控制点 以对的形式加入数组 : [[CGPoint1,CGPoint2],[CGPoint3,CGPoint4]]
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     * superLayer: 父Layer
     * lineDashPattern: 曲线段长度
     */
    class func drawCurve(startPoint: CGPoint, endPoints: [CGPoint], controlPoints: [[CGPoint]], lineWidth: CGFloat, strokColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {

        var path: UIBezierPath?
        for i in stride(from: 0, to: controlPoints.count, by: 1) {
            let array = controlPoints[i]
            if i == 0 {
                path = LLJBezierPath.drawCurve(startPoint: startPoint, endPoint: endPoints[i], controlPoint1: array[0], controlPoint2: array[1])
            } else {
                path?.addCurve(to: endPoints[i], controlPoint1: array[0], controlPoint2: array[1])
            }
        }
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: nil, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
    
    
    /*
     * 画线
     * addLines: 划线点集合  默认第一个为起点
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     * superLayer: 父Layer
     */
    class func drawSin(addLines: [CGPoint], lineWidth: CGFloat, strokeColor: UIColor?, lineDashPattern: [NSNumber]?, superLayer: CALayer) {

        let path = UIBezierPath()
        let startPoint: CGPoint = addLines.first!
        path.move(to: startPoint)
        for item in addLines {
            path.addLine(to: item)
        }
        let layer = LLJLayer.shapeLayer(path: path, strokeStart: nil, strokeEnd: nil, lineWidth: lineWidth, strokeColor: strokeColor, fillColor: nil, lineDashPattern: lineDashPattern)
        superLayer.addSublayer(layer)
    }
}
