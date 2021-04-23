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
     */
    class func drawCyle(rect: CGRect, lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, superView: UIView) {
        
        let path = LLJBezierPath.drawCyle(rect: rect)
        let layer = LLJSUIKitHelper.shapeLayer(bounds: superView.bounds, position: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, backColor: nil)
        layer.path = path.cgPath
        superView.layer.addSublayer(layer)
    }
    
    /*
     * 画圆 圆环
     * superView: 画图显示的试图
     * arcCenter: 圆心; radius: 半径; startAngle: 开始角度; endAngle: 结束角度; clockwise: 顺时针还是逆时针;
     * lineWidth: 线宽; strokColor: 线颜色; fillColor: 填充颜色;
     */
    class func drawCyle(lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, backColor: UIColor?, arcCenter: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool, superView: UIView) {
        
        let path = LLJBezierPath.drawCyle(arcCenter: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        let layer = LLJSUIKitHelper.shapeLayer(bounds: superView.bounds, position: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, backColor: backColor)
        layer.path = path.cgPath
        superView.layer.addSublayer(layer)
    }
    
    
    /*
     * 画多边行 或折线
     * pointArray：多边形顶点数组，第一个点默认起点
     * closePath：true表示关闭，即多边形；false表示不关闭，即折线图
     * lineWidth: 线宽；strokColor：画线颜色；fillColor: 填充色
     */
    class func drawPolygon(pointArray: Array<CGPoint>, closePath: Bool, lineWidth: CGFloat, strokColor: UIColor?, fillColor: UIColor?, superView: UIView) {
        
        let path = LLJBezierPath.drawPolygon(pointArray: pointArray, closePath: closePath)
        let layer = LLJSUIKitHelper.shapeLayer(bounds: superView.bounds, position: nil, lineWidth: lineWidth, strokeColor: strokColor, fillColor: fillColor, backColor: nil)
        layer.path = path.cgPath
        superView.layer.addSublayer(layer)
    }
}
