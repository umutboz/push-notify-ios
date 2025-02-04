//
//  PushNotificationManager.swift
//  PushNotifyManagement
//
//  Created by umutboz on 11.08.2021.
//

import UIKit

/**
 PushNotifyManagement

- parameter PushNotificationType: Creater parameters for constructor.
 # Example #
```
 // let manager = PushNotifyManagement(notificationType: .APNS, application: application)
```
*/

public class PushNotifyManagement: NSObject {
    
//MARK: Objects
    private var notificationType: PushNotificationType?
    private var service: PushNotificationService?
    private var application: UIApplication?
    public var oneFrameManager: OneFrameDashboardManager!
    public var delegate: PushNotifyManagementDelegate?
    
//MARK:: Construction
    /**
     Construction
     - parameter notificationType: PushNotificationType.
     - parameter application: application.   
     */
    
    public init(notificationType: PushNotificationType, application: UIApplication) {
        super.init()
        self.notificationType = notificationType
        self.application = application
        self.configureService()
        self.oneFrameManager = OneFrameDashboardManager()
    }

    ///Configuration method for create service client and notification permissions.
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
        _service.configure { token in
            self.delegate?.pushNotification(token: token)
        }
        
        
        RestClient.setBaseUrl(url: BaseUrl.PROD)
    }
    
    ///Get notification token APNS token or Firebase Token for your PushNotificationType
    public func getNotificationToken() -> String? {
        return self.service?.getToken()
    }
    
    
    //MARK: One Frame Dashboard Notification Service
  
    /**
     Construction
     - parameter clientId: Client ID in dashboard service
     - parameter key: Api key for dashboard service
     */
    public func oneFrameManagerConfig(clientId: String, key: String) {
        self.oneFrameManager.configure(config: OneFrameConfig(clientId: clientId, key: key))
    }
    
   
    
    //MARK: End - One Frame Dashboard Notification Service
    
    
    
    
}

//MARK: User Notificaiton Center Delegate
extension PushNotifyManagement: UNUserNotificationCenterDelegate {
    
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter,
                                       willPresent notification: UNNotification,
                                       withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        delegate?.pushNotification(willPresent: userInfo)
        completionHandler([.sound,.badge])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        delegate?.pushNotification(didReceive: userInfo)
        completionHandler()
    }
    
}



