//
//  APNSClient.swift
//  PNMWrapper
//
//  Created by Özgün Ergen on 11.08.2021.
//

import Foundation

public class APNSClient: PushNotificationService {
    
  
    var name: String {
        return "APNS"
    }
  
    public static var token: String?
    
    func configure() {
        
    }
    func getToken() -> String? {
        return APNSClient.token
    }
    
    func sendToken() {
        // TODO: We will connection api this method
    }
}


