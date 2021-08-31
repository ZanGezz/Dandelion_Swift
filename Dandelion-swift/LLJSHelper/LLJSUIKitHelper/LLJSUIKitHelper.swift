//
//  LLJSUIKitHelper.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/22.
//

import UIKit

public class LLJSUIKitHelper {

    //UIView
    class func LLJView(backGroundColor: UIColor?, frame: CGRect?) -> UIView {
        
        let view = UIView()
        if (backGroundColor != nil) {
            view.backgroundColor = backGroundColor
        }
        if (frame != nil) {
            view.frame = frame!
        }
        return view
    }
    
    //UIView 切统一圆角
    class func LLJCView(subView: UIView, cornerRadius: CGFloat) {
        // 圆角
        LLJCView(subView: subView, cornerRadius: [cornerRadius,cornerRadius,cornerRadius,cornerRadius])
    }
    
    //UIView 切指定不同圆角 cornerRadius = [8,10,12,14] 一次对应topLeft，topRight，bottomRight，bottomLeft的圆角半径
    class func LLJCView(subView: UIView, cornerRadius: [CGFloat]) {
        
        // 圆角
        var path: UIBezierPath?
        var cornerArray = [UIRectCorner]()

        for i in stride(from: 0, to: cornerRadius.count, by: 1) {
            
            if i == 0 {
                cornerArray.append(UIRectCorner.topLeft)
            } else if i == 1 {
                cornerArray.append(UIRectCorner.topRight)
            } else if i == 2 {
                cornerArray.append(UIRectCorner.bottomRight)
            } else if i == 3 {
                cornerArray.append(UIRectCorner.bottomLeft)
            }
        }
        
        path = LLJBezierPath.drawRoundedRect(rect: subView.bounds, byRoundingCorners: cornerArray, cornerRadius: cornerRadius)
        let subLayer = CAShapeLayer()
        subLayer.path = path!.cgPath
        subLayer.frame = subView.bounds
        subView.layer.mask = subLayer;
    }
    
    //按钮
    class func LLJButton(title: String?, titleColor: UIColor?, backGroundColor: UIColor?, titleFont: UIFont?, frame: CGRect?) -> UIButton {
        
        let button = UIButton(type: UIButton.ButtonType.custom)
        if (title != nil) {
            button.setTitle(title, for: UIControl.State.normal)
        }
        if (titleColor != nil) {
            button.setTitleColor(titleColor, for: UIControl.State.normal)
        }
        if (backGroundColor != nil) {
            button.backgroundColor = backGroundColor
        }
        if (titleFont != nil) {
            button.titleLabel?.font = titleFont
        }
        if (frame != nil) {
            button.frame = frame!
        }
        return button;
    }
    
    //Label
    class func LLJLabel(title: String?, titleColor: UIColor?, backGroundColor: UIColor?, titleFont: UIFont?, frame: CGRect?, numberOfLines: Int) -> UILabel {
        
        let label = UILabel()
        if (title != nil) {
            label.text = title
        }
        if (titleColor != nil) {
            label.textColor = titleColor
        }
        if (backGroundColor != nil) {
            label.backgroundColor = backGroundColor
        }
        if (titleFont != nil) {
            label.font = titleFont
        }
        if (frame != nil) {
            label.frame = frame!
        }
        label.numberOfLines = numberOfLines
        return label;
    }
}
