//
//  AppDelegate.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/16.
//  rewriteoc main.m
//  ~/Library/Group Containers/K36BKF7T3D.group.com.apple.configurator/Library/Caches/Assets/TemporaryItems/MobileApps 找到.ipa

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //创建文件存储路径
        createSourcePath()
        //设置根视图
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = LLJTabBarController()
        self.window?.makeKeyAndVisible()
              
        //开启
        UIControl.swizzlAddTargetMethod()
        
        return true
    }
    
}

extension AppDelegate {
    //创建存储路径
    private func createSourcePath() {
        //图片存储路径
        LLJSHelper.createLocalDirectoryPath(path: LLJ_Image_Path())
        //视频存储路径
        LLJSHelper.createLocalDirectoryPath(path: LLJ_Video_Path())
        //CoreData存储路径
        LLJSHelper.createLocalDirectoryPath(path: LLJ_CoreData_Path())
    }
}

