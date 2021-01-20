//
//  LLJTabBarController.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2021/1/18.
//

import UIKit

class LLJTabBarController: UITabBarController {

    var subControllers = Array<LLJNaviController>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI
        setUpUI()
    }
}

//MARK:设置TabBar基础属性
extension LLJTabBarController {
    //设置UI
    private func setUpUI() {
        //设置TabBar基础属性
        setUpTabbarBaseItem()
        //创建子item
        addClildControllers()
    }
    //设置TabBar基础属性
    private func setUpTabbarBaseItem() {
        //去除黑线
        if #available(iOS 13.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.backgroundImage = LLJSHelper.getImageByColorAndSize(LLJWhiteColor(), CGSize(width: SCREEN_WIDTH, height: LLJTabBarHeight))
            tabBarAppearance.shadowColor = LLJWhiteColor()
            self.tabBar.standardAppearance = tabBarAppearance
        } else {
            self.tabBar.shadowImage = LLJSHelper.getImageByColorAndSize(LLJWhiteColor(), CGSize(width: SCREEN_WIDTH, height: 1))
            self.tabBar.backgroundImage = LLJSHelper.getImageByColorAndSize(LLJWhiteColor(), CGSize(width: SCREEN_WIDTH, height: LLJTabBarHeight))
        }
        //设置文字距离底部offset
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        //不设置iponex 系列手机 push返回后 tabbar字体变回蓝色
        self.tabBar.tintColor = LLJPurpleColor()
    }
}

//MARK:增加TabBarItem
extension LLJTabBarController {
    //添加子item
    func addClildControllers() {
        //创建item
        addChildTabItem(chlidController: LLJSMainViewController(), title: "首页", titleColor: nil, titleFont: nil, naviBackColor: nil, naviBackImage: nil, imageName: "shouye_unSelect", selectImageName: "shouye_select")
        //设置tabbar子Item
        self.viewControllers = self.subControllers
    }
    /**
     * 添加TabBar子Item
     */
    func addChildTabItem(chlidController: UIViewController, title: String, titleColor: UIColor?, titleFont: UIFont?, naviBackColor: UIColor?, naviBackImage: UIImage?, imageName: String, selectImageName: String) {
        //设置名称
        chlidController.title = title
        //设置图标
        chlidController.tabBarItem.image = UIImage(named: imageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //设置选中图标
        chlidController.tabBarItem.selectedImage = UIImage(named: selectImageName)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        //设置选中字体颜色
        chlidController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:LLJPurpleColor()], for: UIControl.State.selected)
        //设置未选中字体颜色
        chlidController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:LLJColor(105, 97, 127, 0.5)], for: UIControl.State.normal)
        
        let navi = LLJNaviController(rootViewController: chlidController)
        if (titleColor != nil) {
            navi.setUpTitleColorAndFont(titleColor, nil)
        }
        if (titleFont != nil) {
            navi.setUpTitleColorAndFont(nil, titleFont)
        }
        if (naviBackColor != nil) {
            navi.setUpBackGroundColor(naviBackColor!)
        }
        if (naviBackImage != nil) {
            navi.setUpBackGroundImage(naviBackImage!)
        }
        //添加item到数组
        self.subControllers.append(navi)
    }
}
