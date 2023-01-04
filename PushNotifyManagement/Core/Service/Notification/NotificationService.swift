//
//  NotificationService.swift
//  PushNotifyManagement
//
//  Created by Orhan Özgün Ergen on 3.01.2023.
//

import Foundation


class NotificationService {
    
    
    
   static func registerDevice(token: String, deviceID: String, clientID: String, model: String, version: String) {
        
        let request = RegisterDeviceRequest(token: token, deviceId: deviceID, clientId: clientID, model: model, version: version)
        
        RestClient.default.makeRequest(request: request) { (response: BaseModel<ResponseRegisterDeviceModel>?, error: Error?) in
        
            
            
        }
        
    }
    
}




