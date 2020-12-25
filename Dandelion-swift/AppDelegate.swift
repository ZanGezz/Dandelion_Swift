//
//  AppDelegate.swift
//  Dandelion-swift
//
//  Created by 刘帅 on 2020/12/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = LLJSMainViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }

}

