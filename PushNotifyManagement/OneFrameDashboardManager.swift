//
//  OneFrameDashboardManager.swift
//  PushNotifyManagement
//
//  Created by  umutboz on 5.01.2023.
//

import Foundation
import UIKit

public struct OneFrameConfig {
    var clientId: String
    var key: String
}

public class OneFrameDashboardManager {
    
    private var ofmConfig: OneFrameConfig?

    
    public func configure(config: OneFrameConfig) {
        ofmConfig = config
    }
    
    public func registerDevice(token: String) {
        
        let model = UIDevice.modelName
        let version = DeviceInfo.getOSInfo()
        let deviceId = UIDevice.current.identifierForVendor?.uuidString
        
        guard let _deviceId = deviceId else {
            return
        }
        
        NotificationService.registerDevice(token: token,
                                           deviceID: _deviceId,
                                           clientID: ofmConfig!.clientId,
                                           model: model,
                                           version: version,
                                           apiKey: ofmConfig!.key)
        
    }
    
}
