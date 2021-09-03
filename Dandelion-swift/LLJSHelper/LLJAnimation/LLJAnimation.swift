//
//  LLJAnimation.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/4/16.
//

import UIKit

class LLJAnimation: NSObject {
    
    //创建别名闭包
    typealias supBlock = ((CAAnimation,Bool) -> Void)
    
    var animationDidStop: supBlock?
    
    /*
     * 基础动画 CABasicAnimation (旋转，缩放，淡出，平移)
     * keyPath: 创建动画使用key CALayer或其子类CAShapeLayer等属性中标记为Animatable的，都可以作为key创建动画 详细见注一
     * fromValue: 开始值 toValue: 结束值 byValue: 结束值 (此三个属性值类型跟key类型改变，即：key为position，则fromValue为CGPoint。三个值直接的关系详细见注二)
     * duration: 动画持续时间
     * timingFunctionName: CAMediaTimingFunctionName下枚举(linear：匀速，easeIn：淡入，easeOut：淡出，easeInEaseOut：淡入淡出，default：淡入淡出)
     * repeatCount：动画执行重复次数
     * repeatDuration：动画重复执行时间，优先级高于repeatCount，即时间到，重复次数未到，也会停止
     * fillMode：CAMediaTimingFillMode的枚举(详细见注三)
     * autoreverses：是否反向执行动画
     * removedOnCompletion：执行完是否移除，此属性为true时fillMode不生效
     */
    class func basicAnimation(keyPath: String, beginTime: CFTimeInterval?, fromValue: Any?, toValue: Any?, byValue: Any?, duration: CFTimeInterval, timingFunctionName: CAMediaTimingFunctionName?, repeatCount: Float?, repeatDuration: CFTimeInterval?, fillMode: CAMediaTimingFillMode?, autoreverses: Bool?, removedOnCompletion: Bool?) -> CABasicAnimation {
        let basicAnimation = CABasicAnimation(keyPath: keyPath)
        basicAnimation.fromValue = fromValue
        basicAnimation.toValue = toValue
        basicAnimation.byValue = byValue
        basicAnimation.duration = duration
        basicAnimation.timingFunction = CAMediaTimingFunction(name: timingFunctionName ?? CAMediaTimingFunctionName.linear)
        basicAnimation.repeatCount = repeatCount ?? 0.0
        basicAnimation.repeatDuration = repeatDuration ?? 0.0
        basicAnimation.fillMode = fillMode ?? CAMediaTimingFillMode.removed
        basicAnimation.autoreverses = autoreverses ?? false
        basicAnimation.isRemovedOnCompletion = removedOnCompletion ?? true
        basicAnimation.beginTime = beginTime ?? 0.0
        return basicAnimation
    }
    
    /*
     * 弹性动画 CASpringAnimation
     * keyPath: 创建动画使用key CALayer或其子类CAShapeLayer等属性中标记为Animatable的，都可以作为key创建动画 详细见注一
     * fromValue: 开始值 toValue: 结束值 byValue: 结束值 (此三个属性值类型跟key类型改变，即：key为position，则fromValue为CGPoint。三个值直接的关系详细见注二)
     * duration: 动画持续时间
     * mass: 质量 (越大震动幅度越大)
     * stiffness：刚度系数 (越大震动越快)
     * damping：阻尼系数 (越大停止越快)
     * fillMode：CAMediaTimingFillMode的枚举(详细见注三)
     * initialVelocity：初始速度
     * removedOnCompletion：执行完是否移除，此属性为true时fillMode不生效
     */
    class func springAnimation(keyPath: String, fromValue: Any?, toValue: Any?, byValue: Any?, duration: CFTimeInterval, damping: CGFloat?, stiffness: CGFloat?, mass: CGFloat?, fillMode: CAMediaTimingFillMode?, initialVelocity: CGFloat?, removedOnCompletion: Bool?) -> CASpringAnimation {
        let springAnimation = CASpringAnimation(keyPath: keyPath)
        springAnimation.damping = damping ?? 10.0
        springAnimation.stiffness = stiffness ?? 100
        springAnimation.mass = mass ?? 1.0
        springAnimation.initialVelocity = initialVelocity ?? 0.0
        springAnimation.duration = duration
        springAnimation.fromValue = fromValue
        springAnimation.toValue = toValue
        springAnimation.byValue = byValue
        springAnimation.fillMode = fillMode ?? CAMediaTimingFillMode.removed
        springAnimation.isRemovedOnCompletion = removedOnCompletion ?? true
        return springAnimation
    }
    
    /*
     * 关键帧动画 CAKeyframeAnimation
     * keyPath: 创建动画使用key CALayer或其子类CAShapeLayer等属性中标记为Animatable的，都可以作为key创建动画 详细见注一
     * values: 关键帧值
     * duration: 动画持续时间
     * path: 动画路径(设置此属性后values失效)
     * keyTimes：关键帧每个阶段的时间
     * fillMode：CAMediaTimingFillMode的枚举(详细见注三)
     * removedOnCompletion：执行完是否移除，此属性为true时fillMode不生效
     */
    class func keyframeAnimation(keyPath: String, values: [Any]?, path: CGPath?, keyTimes: [NSNumber]?, duration: CFTimeInterval, timingFunctions: [CAMediaTimingFunction]?, fillMode: CAMediaTimingFillMode?, removedOnCompletion: Bool?) -> CAKeyframeAnimation {
        let keyframeAnimation = CAKeyframeAnimation(keyPath: keyPath)
        keyframeAnimation.duration = duration
        keyframeAnimation.values = values
        keyframeAnimation.path = path
        keyframeAnimation.keyTimes = keyTimes
        keyframeAnimation.timingFunctions = timingFunctions ?? [CAMediaTimingFunction(name: .linear)]
        keyframeAnimation.fillMode = fillMode ?? CAMediaTimingFillMode.removed
        keyframeAnimation.isRemovedOnCompletion = removedOnCompletion ?? true
        return keyframeAnimation
    }
    
    /*
     * 组动画 CAAnimationGroup
     * keyPath: 创建动画使用key CALayer或其子类CAShapeLayer等属性中标记为Animatable的，都可以作为key创建动画 详细见注一
     * animations: 动画组
     */
    class func groupAnimation(keyPath: String, animations:[CAAnimation]?) -> CAAnimationGroup {
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = animations
        groupAnimation.fillMode = .forwards
        groupAnimation.isRemovedOnCompletion = false
        return groupAnimation
    }
}

//MARK: - 注释 -
extension LLJAnimation {
    
    /*
     CAAnimation｛
        CAPropertyAnimation {
            CABasicAnimation {
               CASpringAnimation
            }
            CAKeyframeAnimation
        }
        CATransition
        CAAnimationGroup
     }
     */

    /*  注一: 设置属性动画的属性归总
     
         rotation旋转
         transform.rotation.x
         transform.rotation.y
         transform.rotation.z
     
         scale缩放
         transform.scale.x
         transform.scale.y
         transform.scale.z
     
         translation平移
         transform.translation.x
         transform.translation.y
         transform.translation.z
     
         position
         position.x
         position.y
     
         bounds
         bounds.size
         bounds.size.width
         bounds.size.height
         bounds.origin
         bounds.origin.x
         bounds.origin.y
     
         shadowColor
         shadowOffset
         shadowOpacity
         shadowRadius
         //颜色
         opacity
         backgroundColor
         cornerRadius
         borderWidth
         contents
         strokend
         strokStart
         fillColor
         strokeColor
     */
    
    /* 注二
     * fromValue和toValue不为空,动画的效果会从fromValue的值变化到toValue.
     * fromValue和byValue都不为空,动画的效果将会从fromValue变化到fromValue+byValue
     * toValue和byValue都不为空,动画的效果将会从toValue-byValue变化到toValue
     * 只有fromValue的值不为空,动画的效果将会从fromValue的值变化到当前的状态.
     * 只有toValue的值不为空,动画的效果将会从当前状态的值变化到toValue的值.
     * 只有byValue的值不为空,动画的效果将会从当前的值变化到(当前状态的值+byValue)的值.
     */
    
    /* 注三 isRemovedOnCompletion = true时此属性不生效
     * kCAFillModeForwards对应toValue：动画结束后，图层保持toValue状态
     * kCAFillModeBackwards对应fromValue：动画前，图层一直保持fromValue状态
     * kCAFillModeBoth对应fromValue和toValue：以上两者的结合
     * kCAFillModeRemoved：对图层没有什么影响，动画结束后图层恢复原来的状态
     */
}
