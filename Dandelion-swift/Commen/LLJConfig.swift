//
//  LLJConfig.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/30.
//

import Foundation
import UIKit

/**
 * Log输出
 */
func LLJLog(_ item: Any, _ file: String = #file, _ line: Int = #line, _ function: String = #function) {
    print(file + ":\(line):" + function, item)
}
/**
 * 屏幕宽高、导航高、状态栏、底部菜单栏
 */
//屏幕宽
let SCREEN_WIDTH: CGFloat       = UIScreen.main.bounds.width
//屏幕高
let SCREEN_HEIGHT: CGFloat      = UIScreen.main.bounds.height
//导航栏高
let LLJNAVBAR_HEIGHT: CGFloat   = 44
//状态栏高
let LLJStatusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.height
//顶部总高度
let LLJTopHeight: CGFloat       = LLJStatusBarHeight + LLJNAVBAR_HEIGHT
//底部tabbar高度
let LLJTabBarHeight: CGFloat    = LLJStatusBarHeight > 20 ? 83 : 49
//底部安全高度
let LLJBottomSafeHeight: CGFloat = 34.0


/**
 * 适配
 */
//iphonex系列 尺寸比例系数
let IPhoneXRatio: CGFloat    = SCREEN_HEIGHT/812.0
//适配基础机型款，默认ipone6款375
let IPhoneBaseWidth: CGFloat = 375.0
//对长度进行同比缩放
func LLJDX(_ x: CGFloat) -> CGFloat {
    return x * SCREEN_WIDTH / IPhoneBaseWidth
}
//对两个组件上下距离同比缩放
func LLJDOffSetX(_ x: CGFloat) -> CGFloat {
    return x*(SCREEN_HEIGHT - LLJTopHeight - LLJTabBarHeight)/(896 - LLJTopHeight - LLJTabBarHeight)
}

//距离cell左侧固定设置
let Cell_OffSet_left: CGFloat    = LLJDX(20);
//距离cell右侧固定设置
let Cell_OffSet_right: CGFloat   = LLJDX(16);


/**
 * 机型判断
 */
//是否是IPONEX系列机型
let IS_IPONEX: Bool = LLJTabBarHeight == 83 ? true : false


/**
 * 颜色设置
 */
//自定义颜色
func LLJColor(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat) -> UIColor {
    return UIColor(red: a/255.0, green: b/255.0, blue: c/255.0, alpha: d)
}
//白色
func LLJWhiteColor() -> UIColor {
    return UIColor.white
}
//黑色
func LLJBlackColor() -> UIColor {
    return UIColor.black
}
//项目主体色
func LLJCommenColor() -> UIColor {
    return LLJColor(92,72,102,1)
}
//tabbar字体颜色
func LLJPurpleColor() -> UIColor {
    return LLJColor(105,97,127,1)
}



/**
 * 字体设置
 */
func LLJFont(_ size: CGFloat, _ fontName: String) -> UIFont {
    var fontString : String = fontName
    if (fontString.count == 0) {
        fontString = "PingFangSC-Regular"
    }
    return UIFont.init(name: fontString, size: size)!
}

func LLJFont(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

func LLJBoldFont(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}


/**
 * 本地存储地址设置
 */
let LLJ_Base_Path = NSSearchPathForDirectoriesInDomains(<#T##directory: FileManager.SearchPathDirectory##FileManager.SearchPathDirectory#>, <#T##domainMask: FileManager.SearchPathDomainMask##FileManager.SearchPathDomainMask#>, <#T##expandTilde: Bool##Bool#>)

/**
 * 非空判断
 */

