//
//  LLJTranstionAnimation.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/9/3.
//

import UIKit

enum TransitionType: String {
    case fade = "fade"               //淡入淡出
    case moveIn = "moveIn"           //覆盖
    case push = "push"               //推挤
    case reveal = "reveal"           //揭开
    case cube = "cube"               //立方体
    case suckEffect = "suckEffect"   //吮吸
    case oglFlip = "oglFlip"         //翻转
    case rippleEffect = "rippleEffect" //波纹
    case pageCurl = "pageCurl"         //翻页
    case pageUnCurl = "pageUnCurl"     //反翻页
    case cameraIrisHollowOpen = "cameraIrisHollowOpen"  //开镜头
    case cameraIrisHollowClose = "cameraIrisHollowClose" //关镜头
    case CurlDown = "CurlDown"         //下翻页
    case CurlUp = "CurlUp"             //上翻页
    case FlipFromLeft = "FlipFromLeft" //左翻转
    case FlipFromRight = "FlipFromRight" //右翻转
    
    //自定义
    case openBook
}

enum PushType {
    case push
    case pop
    case present
    case dismiss
}

class LLJTransition: NSObject, UIViewControllerTransitioningDelegate {

    private var duration: TimeInterval = 0.35
    private var animationType: TransitionType = .push
    private var pushType: PushType = .push

    init(add animationType: TransitionType, pushType: PushType, duration: TimeInterval, destinationContrller: UIViewController) {
        super.init()
        
        self.duration = duration
        self.animationType = animationType
        self.pushType = pushType
        
        destinationContrller.transitioningDelegate = self
    }
    
    //推出
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    //返回
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}

////push代理
//extension LLJTransition {
//    //推出
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//    //返回
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return self
//    }
//}

//设置动画
extension LLJTransition: UIViewControllerAnimatedTransitioning {
    
    //设置动画时长
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    //返回动画
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}

//转场动画
//            let animation = LLJTransition.transitionAnimation(type: .cube, subType: .fromRight, duration: 0.35)
//            self.view.window?.layer.add(animation, forKey: "trans")
extension LLJTransition {
    
    /*
     * 基础转场动画 CATransition
     */
    class func transitionAnimation(type: TransitionType, subType: CATransitionSubtype, duration: CFTimeInterval) -> CATransition {
        let transitionAnimation = CATransition()
        transitionAnimation.type = CATransitionType(rawValue: type.rawValue)
        transitionAnimation.subtype = subType
        transitionAnimation.duration = duration
        transitionAnimation.isRemovedOnCompletion = true
        return transitionAnimation
    }
    
    /*
     * 自定义转场动画 1. 仿打开书本
     */
    private func openBook(transitionContext: UIViewControllerContextTransitioning?) {
        let transitionAnimation = CATransition()
    }
}
