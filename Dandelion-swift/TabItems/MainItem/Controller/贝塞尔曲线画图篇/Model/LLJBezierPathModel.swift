//
//  LLJBezierPathModel.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/19.
//

import UIKit

class LLJBezierPathModel: NSObject {
    //标题
    var title: String?
    //frame
    var rect: CGRect?
    //线宽
    var lineWidth: CGFloat?
    //线颜色
    var strokeColor: UIColor?
    //填充色
    var fillColor: UIColor?
    //折线定点数组
    var pointArray: [CGPoint]?
    //圆心
    var arcCenter: CGPoint?
    //半径
    var radius: CGFloat?
    //开始角度
    var startAngle: CGFloat?
    //结束角度
    var endAngle: CGFloat?
    //顺时针
    var clockwise: Bool?
    //是否关闭path
    var closePath: Bool?
}

