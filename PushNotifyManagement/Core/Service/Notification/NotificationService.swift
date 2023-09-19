//
//  NotificationService.swift
//  PushNotifyManagement
//
//  Created by Orhan Özgün Ergen on 3.01.2023.
//  Edited by Umut Boz 19.09.2023.

import Foundation
import os


class NotificationService {
    static let secretHeaderKey = "SecretKey"
    
    
    static func registerDevice(token: String, deviceID: String, clientID: String, model: String, version: String, apiKey : String ) {
        let request = RegisterDeviceRequest(token: token, deviceId: deviceID, clientId: clientID, model: model, version: version)
        RestClient.appendHeaderValue(key: secretHeaderKey , value: apiKey)
        RestClient.default.makeRequest(request: request,apiKey: apiKey) { (response: BaseModel<ResponseRegisterDeviceModel>?, error: Error?) in
            let logger = Logger(subsystem: Bundle.main.bundleIdentifier!, category: "network")
            if let nsError = error as? NSError{
                logger.log("error = \(nsError.localizedDescription)")
            }else{
                logger.log("result = \(response?.result.debugDescription ?? "")")
            }
        }
    }
    
}




