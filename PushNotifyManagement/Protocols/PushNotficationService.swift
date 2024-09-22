//
//  PushNotficationService.swift
//  PushNotifyManagement
//
//  Created by umutboz on 11.08.2021.
//

import Foundation


protocol PushNotificationService {
    
    var name: String { get }
    static var token: String? {set get}
    var pushNotificationToken: ((_ token: String) -> ())! {get set}
    func configure(PNToken: @escaping ((_ token: String) -> ()))
    func sendToken()
    func getToken() -> String?
    
}
