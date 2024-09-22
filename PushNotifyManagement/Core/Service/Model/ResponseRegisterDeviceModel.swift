//
//  ResponseRegisterDeviceModel.swift
//  PushNotifyManagement
//
//  Created by  umutboz on 3.01.2023.
//

import Foundation
// MARK: - Result
struct ResponseRegisterDeviceModel: Codable {
    let id, deviceID, clientID, type: String
    let model, version: String

    enum CodingKeys: String, CodingKey {
        case id
        case deviceID = "deviceId"
        case clientID = "clientId"
        case type, model, version
    }
}
