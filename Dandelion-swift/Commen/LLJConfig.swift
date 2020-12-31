//
//  LLJConfig.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/30.
//

import Foundation
import UIKit

/**
 * 屏幕宽高、导航高、状态栏、底部菜单栏
 */
let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/**
 * 机型判断
 */

/**
 * 颜色设置
 */

//自定义颜色
func LLJColor(_ a: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat) -> UIColor {
    return UIColor(red: a, green: b, blue: c, alpha: d)
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

/**
 * 字体设置
 */

/**
 * 本地存储地址设置
 */

/**
 * 非空判断
 */

