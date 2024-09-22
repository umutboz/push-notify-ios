# PushNotifyManagement

# Introduction
Kocsistem Support PushNotifyManagetment component for the notification at IOS app. This component is supporting **Firebase** and **Apple Push Notification Service**.

# Cocoapods

pod 'push-notify' , :git => 'https://github.com/umutboz/push-notify-ios.git', :tag => '1.0.0'

# Requirement

*   iOS 10.0+ / macOS 10.14.4+ / tvOS 9.0+ / watchOS 2.0+
*   Xcode 10.0+
*   Swift

# Integration For Firebase

1. Added **GoogleService-Info.plist** file your project folder
2. Appdelegate file updating with this line 
```
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var manager: PushNotifyManagement!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configurationPushNotification(application: application)
        return true
    }
    
    func configurationPushNotification(application: UIApplication) {
        self.manager = PushNotifyManagement(notificationType: .Firebase,
                                               application: application)
        //INTEGRATION OFM PUSH PORTAL
        //https://oneframe-notification-hub-test.azurewebsites.net/
        self.manager.oneFrameManagerConfig(clientId: "CLIENT_ID", key: "API_KEY")
        self.manager.delegate = self
    }
}

extension AppDelegate: PushNotifyManagementDelegate {

    func pushNotification(token: String) {
        self.manager.oneFrameManager.registerDevice(token: token)
    }

    func pushNotification(didReceive notification: [AnyHashable : Any]) {
        
    }
    func pushNotification(willPresent notification: [AnyHashable : Any]) {

    }
}

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X",    $1)})
        print("Device Token ", tokenString )
        APNSClient.token = tokenString
    }
}

```

# Integration For APNS

2. Appdelegate file updating with this line
```
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var manager: PushNotifyManagement!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configurationPushNotification(application: application)
        return true
    }
    
    func configurationPushNotification(application: UIApplication) {
        self.manager = PushNotifyManagement(notificationType: .APNS,
                                               application: application)
        self.manager.delegate = self
    }
}

extension AppDelegate: PushNotifyManagementDelegate {

    func pushNotification(didReceive notification: [AnyHashable : Any]) {
        
    }
    func pushNotification(willPresent notification: [AnyHashable : Any]) {

    }
}

extension AppDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X",    $1)})
        print("Device Token ", tokenString )
        APNSClient.token = tokenString
    }
}

```

# Enums Property

```
public enum PushNotificationType {
    
    case APNS
    case Firebase
    
    
}
```
