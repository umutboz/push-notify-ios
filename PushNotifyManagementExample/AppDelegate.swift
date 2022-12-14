//
//  AppDelegate.swift
//  PushNotifyManagementExample
//
//  Created by Özgün Ergen on 10.08.2021.
//

import UIKit
import PushNotifyManagement

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var manager: PushNotifyManagement!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configurationPushNotification(application: application)
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func configurationPushNotification(application: UIApplication) {
        
        
        
        self.manager = PushNotifyManagement(notificationType: .Firebase,
                                               application: application)
        if AppConstants.isUITest == false {
            self.manager.delegate = self
        }
    }
    
}
extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X",    $1)})
        print("Device Token ", tokenString )
        APNSClient.token = tokenString

    }
}


extension AppDelegate: PushNotifyManagementDelegate {
    
    func pushNotification(token: String) {
        
    }
    

    func pushNotification(didReceive notification: [AnyHashable : Any]) {
        
    }
    
    func pushNotification(willPresent notification: [AnyHashable : Any]) {

    }
    
}

//Read me
//
