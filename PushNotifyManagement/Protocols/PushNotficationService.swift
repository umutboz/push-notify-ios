//
//  PushNotficationService.swift
//  PNMWrapper
//
//  Created by Özgün Ergen on 11.08.2021.
//

import Foundation


protocol PushNotificationService {
    
    var name: String { get }
    static var token: String? {set get}
    
    func configure()
    func sendToken()
    func getToken() -> String?
    
}
