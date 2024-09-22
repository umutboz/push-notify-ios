//
//  PushNotifyManagementTests.swift
//  PushNotifyManagementTests
//
//  Created by umutboz on 10.08.2021.
//

import XCTest
import PushNotifyManagement

class PushNotifyManagementTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let firebaseClient = FirebaseClient()
        firebaseClient.getToken()
        XCTAssertNotNil(firebaseClient)
    }
   
    override func tearDown() {
        super.tearDown()
    }
    
    func getFirebaseClient() {
       
    }

}
