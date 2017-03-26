//
//  AppDelegate.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 本地通知
        // setNotification()
        
        // 3d touch
        set3dTouch()
        
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
    
    func setNotification() -> Void {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (isOk, error) in
                if isOk {
                    // 1. 创建通知内容
                    let content = UNMutableNotificationContent()
                    content.title = "title"
                    content.body = "body"
                    content.subtitle = "subTile"
                    // 2. 创建发送触发
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    // 3. 发送请求标识符
                    let requestIdentifier = "com.onevcat.usernotification.myFirstNotification"
                    // 4. 创建一个发送请求
                    let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
                    // 将请求添加到发送中心
                    UNUserNotificationCenter.current().add(request) { error in
                        if error == nil {
                            print("Time Interval Notification scheduled:  \(requestIdentifier)")
                        }
                    }
                }
            }
        } else {
            let localNotification = UILocalNotification()
            localNotification.alertBody = "你有新的信息"
            localNotification.alertAction = "滑动查看"
            localNotification.fireDate = NSDate(timeIntervalSinceNow: 10) as Date
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void){
        // 处理完成后条用 completionHandler ，用于指示在前台显示通知的形式
        completionHandler(.alert)
        print(notification)
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void){
        print(response)
    }
    
    //
    func set3dTouch() -> Void {
        let homeIcon = UIApplicationShortcutIcon(type: .pause)
        let home = UIApplicationShortcutItem(type: "home", localizedTitle: "测试首页", localizedSubtitle: "副标题", icon: homeIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [home]
    }
    
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

