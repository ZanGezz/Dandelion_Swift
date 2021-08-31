//
//  LLJNaviController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/18.
//

import UIKit

class LLJNaviController: UINavigationController {

    //状态栏样式
    var _statusBarStyle: UIStatusBarStyle = .default
    //状态栏动画
    var statusBarAnimation: UIStatusBarAnimation = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }
}

extension LLJNaviController: UIGestureRecognizerDelegate {
    //设置UI
    private func setUpUI() {
        //设置左滑返回代理
        self.interactivePopGestureRecognizer?.delegate = self
        //隐藏黑线
        UINavigationBar.appearance().shadowImage = UIImage()
        //设置背景默认白色
        setUpBackGroundColor(LLJBlackColor())
        //设置默认字体18颜色白色
        setUpTitleColorAndFont(LLJWhiteColor(), LLJFont(18, "PingFangSC-Medium"))
    }
    /*
     * 设置标题和颜色
     */
    func setUpTitleColorAndFont(_ color: UIColor?, _ font: UIFont?) {
        let dic = [NSAttributedString.Key.foregroundColor:color,NSAttributedString.Key.font:font]
        self.navigationBar.titleTextAttributes = dic as [NSAttributedString.Key : Any]
    }
    /*
     * 设置背景颜色
     */
    func setUpBackGroundColor(_ color: UIColor) {
        let image = LLJSHelper .getImageByColorAndSize(color, CGSize(width: SCREEN_WIDTH, height: LLJTopHeight))
        setUpBackGroundImage(image)
    }
    /*
     * 设置背景图片
     */
    func setUpBackGroundImage(_ image: UIImage) {
        self.navigationBar.setBackgroundImage(image, for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    
    /*
     * 左滑返回功能代理
     */
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == self.interactivePopGestureRecognizer {
            if self.viewControllers.count <= 1 {
                //根视图禁止左滑手势
                return false;
            } else {
                let viewController = self.viewControllers.last as! LLJFViewController
                if viewController.forbidGesturePopViewController {
                    return false
                } else {
                    return true
                }
            }
        }
        return false
    }
}

extension LLJNaviController {
    
    /*
     * 状态栏样式
     */
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    /*
     * 状态栏动画
     */
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation{
        return .none
    }
    
    //代理
    var statusBarStyle: UIStatusBarStyle {
        set {
            _statusBarStyle = newValue
            
            self.setNeedsStatusBarAppearanceUpdate()
        }
        get {
            return _statusBarStyle
        }
    }
}
