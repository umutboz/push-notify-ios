//
//  ViewController.swift
//  PNMWrapperExample
//
//  Created by Özgün Ergen on 10.08.2021.
//

import UIKit
import PushNotifyManagement
class ViewController: UIViewController {

    var manager: PushNotifyManagement!

    @IBOutlet weak var notificationDidReceiveLabel: UILabel!
    @IBOutlet weak var notificationWillPresentLabel: UILabel!
    @IBOutlet weak var apnsTokenLabel: UILabel!
    @IBOutlet weak var firebaseTokenLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        if AppConstants.isUITest {
            appDelegate.manager.delegate = self
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
            print("1-")
        
            self.apnsTokenLabel.text = appDelegate.manager.getNotificationToken()
            self.firebaseTokenLabel.text = appDelegate.manager.getNotificationToken()
        }
        
        
    }
    
    @IBAction func showNotificationTapped(_ sender: Any) {
        scheduleLocalNotification()
    }
    
    private func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()

        // Configure Notification Content
        notificationContent.title = "Title"
        notificationContent.subtitle = "Subtitle"
        notificationContent.body = "Body"

        // Set Category Identifier
        notificationContent.categoryIdentifier = "categoryID"

        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)

        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }

}

extension ViewController: PushNotifyManagementDelegate {
    
    func pushNotification(didReceive notification: [AnyHashable : Any]) {
        notificationDidReceiveLabel.text = "Notification Did Received"
        
    }
    
    func pushNotification(willPresent notification: [AnyHashable : Any]) {
        notificationWillPresentLabel.text = "Notification Will Present"
    }
    
}
