//
//  AppDelegate.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let homeIcon = UIApplicationShortcutIcon(type: .pause)
        let home = UIApplicationShortcutItem(type: "home", localizedTitle: "测试首页", localizedSubtitle: "副标题", icon: homeIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [home]
        
        //
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let tabbarVC = TabBarViewController()
        let newsNavVC = BooksNavViewController(rootViewController: BooksViewController())
        let girlNavVC = GirlNavViewController(rootViewController: GirlViewController())
        tabbarVC.addChildViewController(newsNavVC)
        tabbarVC.addChildViewController(girlNavVC)
        
        window?.rootViewController = tabbarVC
        
        window?.makeKeyAndVisible()
        
        return true
    }

    // 3d touch 菜单跳转
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "home":
            
            break
        default:
            break
        }
    }
    
    //
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

