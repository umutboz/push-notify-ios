//
//  FirebaseClient.swift
//  PushNotifyManagement
//
//  Created by Özgün Ergen on 11.08.2021.
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
    
    func configure() {
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
    }
    
    func getToken() -> String? {
        return FirebaseClient.token
    }
    
    func sendToken() {
        // TODO: We will connection api this method
    }
    
}

extension FirebaseClient: MessagingDelegate {
   
    public func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        FirebaseClient.token = fcmToken
    }
    
    public func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    public func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        FirebaseClient.token = fcmToken
    }
}
