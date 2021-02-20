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
    
    //UIView 切圆角 阴影
    class func LLJCView(subView: UIView, cornerRadius: CGFloat?, shadowColor: UIColor?, shadowOffset: CGSize?, shadowOpacity: Float?, shadowRadius: CGFloat?) -> UIView {
        
        // 圆角
        if (cornerRadius != nil) {
            subView.layer.cornerRadius = cornerRadius!;
        }
        // 阴影颜色
        if (shadowColor != nil) {
            subView.layer.shadowColor = shadowColor?.cgColor;
        }
        // 阴影偏移，默认(0, -3)
        if (shadowOffset != nil) {
            subView.layer.shadowOffset = shadowOffset!;
        }
        // 阴影透明度，默认0
        if (shadowOpacity != nil) {
            subView.layer.shadowOpacity = shadowOpacity!;
        }
        // 阴影半径，默认3
        if (shadowRadius != nil) {
            subView.layer.shadowRadius = shadowRadius!;
        }
        return subView
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
