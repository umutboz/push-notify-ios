//
//  Coders.swift
//  PushNotifyManagement
//
//  Created by  umutboz on 3.01.2023.
//

import class Foundation.JSONDecoder
import Foundation

public enum Coders {
    static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        return encoder
    }()
    
    static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        return decoder
    }()
}
