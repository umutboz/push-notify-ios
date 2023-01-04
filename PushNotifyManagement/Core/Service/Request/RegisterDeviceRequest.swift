//
//  RegisterDeviceRequest.swift
//  PushNotifyManagement
//
//  Created by Orhan Özgün Ergen on 3.01.2023.
//

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
        return [

        URLQueryItem(name: "Content-Type", value: "application/json"),
        URLQueryItem(name: "Authorization", value: "Bearer " + "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJlMGNiMzNmMy01OTFhLTRhMjUtYWFiYS1iZDA1Zjc5NmI1ZmIiLCJ1bmlxdWVfbmFtZSI6ImFkbWludXNlckBrb2NzaXN0ZW0uY29tLnRyIiwianRpIjoiMGQ4MDY4YjQtMzI2Zi00MzAyLWIwOGUtNjlkMDdkN2I4YTE1IiwiZW1haWwiOiJhZG1pbnVzZXJAa29jc2lzdGVtLmNvbS50ciIsImdpdmVuX25hbWUiOiJTY290IiwiZmFtaWx5X25hbWUiOiJMYXdzb24iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJBZG1pbiIsIktzUGVybWlzc2lvbiI6WyJNYW5hZ2VtZW50X1JvbGVfQWRkQ2xhaW0iLCJNYW5hZ2VtZW50X1JvbGVfQWRkVXNlciIsIk1hbmFnZW1lbnRfUm9sZV9DbGFpbUxpc3QiLCJNYW5hZ2VtZW50X1JvbGVfQ3JlYXRlIiwiTWFuYWdlbWVudF9Sb2xlX0RlbGV0ZSIsIk1hbmFnZW1lbnRfUm9sZV9FZGl0IiwiTWFuYWdlbWVudF9Sb2xlX0xpc3QiLCJNYW5hZ2VtZW50X1JvbGVfUmVtb3ZlQ2xhaW0iLCJNYW5hZ2VtZW50X1JvbGVfUmVtb3ZlVXNlciIsIk1hbmFnZW1lbnRfUm9sZV9Vc2VyTGlzdCIsIk1hbmFnZW1lbnRfVXNlcl9BZGRDbGFpbSIsIk1hbmFnZW1lbnRfVXNlcl9DbGFpbUxpc3QiLCJNYW5hZ2VtZW50X1VzZXJfQ3JlYXRlIiwiTWFuYWdlbWVudF9Vc2VyX0RlbGV0ZSIsIk1hbmFnZW1lbnRfVXNlcl9FZGl0IiwiTWFuYWdlbWVudF9Vc2VyX0xpc3QiLCJNYW5hZ2VtZW50X1VzZXJfUmVtb3ZlQ2xhaW0iLCJNYW5hZ2VtZW50X0FwcGxpY2F0aW9uU2V0dGluZ19MaXN0IiwiTWFuYWdlbWVudF9BcHBsaWNhdGlvblNldHRpbmdfRWRpdCIsIk1hbmFnZW1lbnRfQXBwbGljYXRpb25TZXR0aW5nX0RlbGV0ZSIsIk1hbmFnZW1lbnRfQXBwbGljYXRpb25TZXR0aW5nX0NyZWF0ZSIsIk1hbmFnZW1lbnRfQXBwbGljYXRpb25TZXR0aW5nQ2F0ZWdvcnlfTGlzdCIsIk1hbmFnZW1lbnRfQXBwbGljYXRpb25TZXR0aW5nQ2F0ZWdvcnlfRWRpdCIsIk1hbmFnZW1lbnRfQXBwbGljYXRpb25TZXR0aW5nQ2F0ZWdvcnlfRGVsZXRlIiwiTWFuYWdlbWVudF9BcHBsaWNhdGlvblNldHRpbmdDYXRlZ29yeV9DcmVhdGUiLCJSZXBvcnRfTG9naW5BdWRpdExvZ19MaXN0IiwiTWFuYWdlbWVudF9FeGNlbF9FeHBvcnQiLCJNYW5hZ2VtZW50X0VtYWlsVGVtcGxhdGVfTGlzdCIsIk1hbmFnZW1lbnRfRW1haWxUZW1wbGF0ZV9FZGl0IiwiUmVwb3J0X0VtYWlsTm90aWZpY2F0aW9uX0xpc3QiLCJSZXBvcnRfRW1haWxOb3RpZmljYXRpb25fU2VuZCIsIk1hbmFnZW1lbnRfVXNlcl9Sb2xlIiwiTWFuYWdlbWVudF9NZW51X0xpc3QiLCJNYW5hZ2VtZW50X01lbnVfRWRpdCIsIk1hbmFnZW1lbnRfTGFuZ3VhZ2VfTGlzdCIsIk1hbmFnZW1lbnRfTGFuZ3VhZ2VfRWRpdCIsIkNvbXBhbnlfTGlzdCIsIkNvbXBhbnlfQ3JlYXRlIiwiQ29tcGFueV9FZGl0IiwiQ29tcGFueV9EZWxldGUiLCJDbGllbnRfTGlzdCIsIkNsaWVudF9DcmVhdGUiLCJDbGllbnRfRWRpdCIsIkNsaWVudF9EZWxldGUiLCJQdXNoTm90aWZpY2F0aW9uRGV2aWNlX0xpc3QiLCJQdXNoTm90aWZpY2F0aW9uRGV2aWNlX0NyZWF0ZSIsIlB1c2hOb3RpZmljYXRpb25EZXZpY2VfRWRpdCIsIlB1c2hOb3RpZmljYXRpb25EZXZpY2VfRGVsZXRlIiwiUHVzaE5vdGlmaWNhdGlvblRlbXBsYXRlX0xpc3QiLCJQdXNoTm90aWZpY2F0aW9uVGVtcGxhdGVfQ3JlYXRlIiwiUHVzaE5vdGlmaWNhdGlvblRlbXBsYXRlX0VkaXQiLCJQdXNoTm90aWZpY2F0aW9uVGVtcGxhdGVfRGVsZXRlIiwiUHVzaE5vdGlmaWNhdGlvblJlcXVlc3RfTGlzdCIsIlB1c2hOb3RpZmljYXRpb25SZXF1ZXN0X0NyZWF0ZSIsIlB1c2hOb3RpZmljYXRpb25SZXF1ZXN0X0VkaXQiLCJQdXNoTm90aWZpY2F0aW9uUmVxdWVzdF9EZWxldGUiLCJTZW5kUHVzaE5vdGlmaWNhdGlvbiJdLCJleHAiOjE3MDQzNzQwODUsImlzcyI6Ikp3dFNlcnZlciIsImF1ZCI6Ikp3dFNlcnZlciJ9.M31qORUcd8Rg2kIo2ARi3_vYp-6TpoVlcqhAg88dkuk"),
        ]
    }

   // var token: String!
    var deviceId: String!
    var clientId: String
    var model: String!
    var version: String!
    var type: String = "Ios"
    
    init(token: String, deviceId: String!, clientId: String , model: String!, version: String!) {
        
        self.clientId = clientId
       // self.token = token
        self.deviceId = deviceId
        self.model = model
        self.version = version
    }
    
}

