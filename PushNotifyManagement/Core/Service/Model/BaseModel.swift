//
//  BaseModel.swift
//  PushNotifyManagement
//
//  Created by  umutboz on 3.01.2023.
//

import Foundation


// MARK: - LicanceModel
struct BaseModel<T: Codable>: Codable {
    let result: T?
    let error: BaseError?
    let isSuccessful: Bool
}

// MARK: - Error
struct BaseError: Codable {
    let code: Int
    let correlationID, details, message: String
    let validationErrors: String?

    enum CodingKeys: String, CodingKey {
        case code
        case correlationID = "correlationId"
        case details, message, validationErrors
    }
}




