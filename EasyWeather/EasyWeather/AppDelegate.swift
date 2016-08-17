//
//  AppDelegate.swift
//  EasyWeather
//
//  Created by zly.private on 16/7/28.
//  Copyright © 2016年 hurricane. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //初始化app窗口,将窗口设置为全屏
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        if (window != nil) {
            //将上述窗口设置为该app唯一的主窗口，并且直接显示出来
            self.window!.makeKeyAndVisible()
            //在上述名为Main的故事板中依据名字rootVC找到相应的页面，并且将该页面设置为主窗口的根页面
            self.window!.rootViewController = MainViewController();
        }
        if #available(iOS 9.1, *) {
            if Tools.getUserDefaults("weather") != nil && Tools.getUserDefaults("temperature_now") != nil{
                let myIcon: UIApplicationShortcutIcon! = UIApplicationShortcutIcon.init(type: .Home)
                //
                let shortcutItem: UIMutableApplicationShortcutItem! = UIMutableApplicationShortcutItem.init(type: "ShowWeather", localizedTitle: "天气", localizedSubtitle: "查看当前天气", icon: myIcon, userInfo: ["version/3":"1"])
                UIApplication.sharedApplication().shortcutItems = [shortcutItem]
            }
        } else {
            // Fallback on earlier versions
        }
        
        // 权限检查
        checkNotificationPre(application)
        
        // 检查用户是否允许发送通知 允许就设置通知，不允许就取消通知
        checkNotificationOpen(application)
        
        return true
    }
    
    // 3dTouch之后的事情
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void){
        if shortcutItem.type == "ShowWeather" {
            // TODO
        }
    }
    
    // 应用在正在运行(在前台或后台运行)，点击通知后触发appDelegate代理方法:：didReceiveLocalNotification
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        print("运行了代理:\(notification.userInfo)")
        application.applicationIconBadgeNumber = 0
    }
    
    // 应用未运行，点击通知启动app，走appDelegate代理方法:didFinishLaunchingWithOptions
    func applicationDidFinishLaunching(application: UIApplication) {
        
    }
    
    func checkNotificationOpen(application: UIApplication) -> Void {
        //
        let setting = UIApplication.sharedApplication().currentUserNotificationSettings()
        let cell = SingleManager.singleManager.getValue(Key: "ChooseNotificationTimeTableViewCell") as? ChooseNotificationTimeTableViewCell

        // 说明开启了通知
        if setting != nil && setting!.types != .None {
            print("开通知")
            Tools.setUserDefaults(key: "TurnOnOrOffNotifation", andVluew: true)

            if (cell != nil) {
                cell!.showText = Tools.getUserDefaults("Notification_Time") != nil ? (Tools.getUserDefaults("Notification_Time") as! String) : "08:00:00"
                cell!.turnOnOrOffNotifationValue = Tools.readSettingPlist("TurnOnNotification") as! Bool
            }
            
            // 开启通知
            checkNotification(application)
        }else {
             print("关通知")
            // 如果未开启通知 那么我这里开了通知也发送不出去, 而且此处也不运行通知 而是取消通知
            UIApplication.sharedApplication().cancelAllLocalNotifications()
            Tools.setUserDefaults(key: "TurnOnOrOffNotifation", andVluew: false)

            // 实时的改变状态
            if (cell != nil) {
                cell!.showText = "未开启通知"
                cell!.turnOnOrOffNotifationValue = Tools.readSettingPlist("TurnOnNotification") as! Bool
            }
        }
    }
    
    // 检查通知权限
    func checkNotificationPre(application: UIApplication) -> Void {
        
        // 通知的权限请求
        if (UIApplication.instancesRespondToSelector(#selector(UIApplication.registerUserNotificationSettings(_:)))) {
            UIApplication.sharedApplication().registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil))
        }
    }
    
    // 检查发送通知 并且设定
    func checkNotification(application: UIApplication) -> Void {
        // 先取消通知
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        application.applicationIconBadgeNumber = 0
        let localNotification = UILocalNotification()
        
        // 当前时间
        let currentDate = NSDate()
        let timeZone = NSTimeZone.systemTimeZone()
        let interval = timeZone.secondsFromGMTForDate(currentDate)
        let localDate = currentDate.dateByAddingTimeInterval(Double(interval))
        print("当前时间\(localDate)")
        
        // 每天8点
        let format = NSDateFormatter()
        format.dateFormat = "HH:mm:ss"
        
        var date:NSDate!
        if Tools.getUserDefaults("Notification_Time") != nil {
            date = format.dateFromString(Tools.getUserDefaults("Notification_Time") as! String)
            print(Tools.getUserDefaults("Notification_Time"))
        }else {
            date = format.dateFromString("08:00:00")
            Tools.setUserDefaults(key: "Notification_Time", andVluew: "08:00:00")
        }
        // 通知时间
        localNotification.fireDate = date
        // 设置时区
        localNotification.timeZone = NSTimeZone.defaultTimeZone()
        //
        localNotification.alertTitle = "每日天气提醒"
        // 通知上显示的主题内容
        localNotification.alertBody = "新的一天开始，看看天气怎么样吧"
        // 收到通知时播放的声音，默认消息声音
        localNotification.soundName = UILocalNotificationDefaultSoundName
        // 重复周期
        localNotification.repeatInterval = .Day
        //待机界面的滑动动作提示
        localNotification.alertAction = "打开应用"
        // 应用程序图标右上角显示的消息数
        localNotification.applicationIconBadgeNumber = 1
        // 通知上绑定的其他信息，为键值对
        //localNotification.userInfo = ["id": "1",  "name": "xxxx"]
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    // 进入后台
    func applicationDidEnterBackground(application: UIApplication) {
        
    }
    
    // 进入前台
    func applicationWillEnterForeground(application: UIApplication) {
        NSNotificationCenter.defaultCenter().postNotificationName("ReGetLocationAndReGetWeather", object: nil)
        // 检查用户是否允许发送通知 允许就设置通知，不允许就取消通知
        checkNotificationOpen(application)
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.hurricane.EasyWeather" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("EasyWeather", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }
    
}

