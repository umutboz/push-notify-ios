//
//  FirebaseClient.swift
//  PushNotifyManagement
//
//  Created by umutboz on 11.08.2021.
//

import Foundation
import FirebaseCore
import FirebaseMessaging


/**
 FirebaseClient, This class configure all firabese configuration
 
 - parameter name
 - parameter token
 */
public class FirebaseClient: NSObject, PushNotificationService {
    
    var name: String {
        return "FIREBASE"
    }
    
    static var token: String?
    
    public var pushNotificationToken: ((_ token: String) -> ())!
    
    func configure(PNToken: @escaping ((_ token: String) -> ())) {
        pushNotificationToken = PNToken
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    
    public func getToken() -> String? {
        return FirebaseClient.token
    }
    
    func sendToken() {
        // TODO: We will connection api this method
    }
    
    
    
}

extension FirebaseClient: MessagingDelegate {
    
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        FirebaseClient.token = fcmToken
        pushNotificationToken(fcmToken ?? "")
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    public func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        FirebaseClient.token = fcmToken
        pushNotificationToken(fcmToken)
        
    }
}
