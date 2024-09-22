//
//  PushNotifyManagementUITests.swift
//  PushNotifyManagementUITests
//
//  Created by umutboz on 12.08.2021.
//

import XCTest

class PushNotifyManagementUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        // UI tests must launch the application that they test
        let app = XCUIApplication()
        app.launch()
        let showNotification = app.buttons["showNotification"]

        let apnsToken = app.staticTexts["apnsToken"]
        let notificationDidReceive = app.staticTexts["notificationDidReceive"]
        let notificationWillPresent = app.staticTexts["notificationWillPresent"]


        XCTAssert(apnsToken.waitForExistence(timeout: 7))
        showNotification.tap()
        XCTAssertNotNil(apnsToken.label)

        XCTAssert(notificationWillPresent.waitForExistence(timeout: 2))
        XCTAssertEqual("Notification Will Present", notificationWillPresent.label)
                
    }
    
 
   
}
