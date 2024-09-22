//
//  PushNotificationDelegate.swift
//  PushNotifyManagement
//
//  Created by umutboz on 12.08.2021.
//

import Foundation

public protocol PushNotifyManagementDelegate {
    
    func pushNotification(willPresent notification: [AnyHashable: Any])
    func pushNotification(didReceive notification: [AnyHashable: Any])
    func pushNotification(token: String)
}
