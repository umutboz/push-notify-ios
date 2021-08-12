//
//  PushNotificationManager.swift
//  PNMWrapper
//
//  Created by Özgün Ergen on 11.08.2021.
//

import UIKit

/// PushNotificationManager
public class PushNotifyManagement: NSObject {
    
//MARK: Objects
    private var notificationType: PushNotificationType?
    private var service: PushNotificationService?
    private var application: UIApplication?
    public var delegate: PushNotifyManagementDelegate?
    
//MARK:: Construction
    public init(notificationType: PushNotificationType, application: UIApplication) {
        super.init()
        self.notificationType = notificationType
        self.application = application
        self.configureService()
    }

    func configureService() {
        
        switch self.notificationType {
        case .APNS:
            self.service = APNSClient()
            break;
        case .Firebase:
            self.service = FirebaseClient()
            break;
        case .none: break
        }
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().delegate = self // Bildirim Ayarları için UNUserNotificationCenterDelegate kullanmak için kullanılır.
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        
        
        //Application
        guard let _application = application else {
            return
        }
        _application.registerForRemoteNotifications()
        
        //Service configure
        guard let _service = self.service else {
            return
        }
        _service.configure()
        
        
    }
    
    public func getNotificationToken() -> String? {
        return self.service?.getToken()
    }
    
}

//MARK: User Notificaiton Center Delegate
extension PushNotifyManagement: UNUserNotificationCenterDelegate {
    
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        delegate?.pushNotification(willPresent: userInfo)
        completionHandler([.sound,.badge,.banner])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        delegate?.pushNotification(didReceive: userInfo)
        completionHandler()
    }
    
}

