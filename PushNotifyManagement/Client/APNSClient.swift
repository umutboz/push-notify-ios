//
//  APNSClient.swift
//  PushNotifyManagement
//
//  Created by umutboz on 11.08.2021.
//

import Foundation
/**
 APNSClient, This class configure all APNS configuration
 
 - parameter name
 - parameter token
 */
public class APNSClient: PushNotificationService {
    
    
    var name: String {
        return "APNS"
    }
    
    public static var token: String? 
    
    var pushNotificationToken: ((_ token: String) -> ())!
    
    func configure(PNToken: @escaping ((_ token: String) -> ())) {
        pushNotificationToken = PNToken
    }
    func getToken() -> String? {
        return APNSClient.token
    }
    
    func sendToken() {
        // TODO: We will connection api this method
    }
}


