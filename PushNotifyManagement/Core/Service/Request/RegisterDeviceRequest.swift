//
//  RegisterDeviceRequest.swift
//  PushNotifyManagement
//
//  Created by  umutboz on 3.01.2023.
//  Edited by Umut Boz 19.09.2023.

import Foundation



class RegisterDeviceRequest: Request, Codable {
    
    var contentType: ContentType {
        return ContentType.json
    }
    var method: RequestMethod {
        return .post
    }
    
    var endpoint: String {
        return Endpoint.registerDevice
    }
    
    var onlyFullPathUrlWithQueries: Bool {
        return true
    }

        
    var headerParameters: [URLQueryItem] {
           return [ URLQueryItem(name: "Content-Type", value: "application/json")]
    }

    
   // var token: String!
    var deviceId: String!
    var clientId: String
    var model: String!
    var firebaseToken: String!
    var version: String!
    var type: String = "iOS"
    
    init(token: String, deviceId: String!, clientId: String , model: String!, version: String!) {
        
        self.clientId = clientId
        self.firebaseToken = token
        self.deviceId = deviceId
        self.model = model
        self.version = version
    }
    
}

