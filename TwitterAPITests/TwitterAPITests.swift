//
//  TwitterAPITests.swift
//  TwitterAPITests
//
//  Created by Shinichiro Aska on 9/19/15.
//  Copyright © 2015 Shinichiro Aska. All rights reserved.
//

import XCTest
import TwitterAPI
import OAuthSwift

#if os(iOS)
    import Accounts
    import Social
#endif

class TwitterAPITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSerializeOAuth() {
        let client = OAuthClient(consumerKey: "hoge", consumerSecret: "foo", accessToken: "bar", accessTokenSecret: "baz")
        XCTAssertEqual(client.serialize, "OAuth\thoge\tfoo\tbar\tbaz", "client.serialize")
        
        let clientCopy = ClientDeserializer.deserialize(client.serialize)
        XCTAssertEqual(clientCopy.serialize, "OAuth\thoge\tfoo\tbar\tbaz", "client.serialize")
    }
    
    func testGET() {
        let client = OAuthClient(consumerKey: "hoge", consumerSecret: "foo", accessToken: "bar", accessTokenSecret: "baz")
        let request = client.get("https://api.twitter.com/1.1/statuses/home_timeline.json")
        XCTAssertEqual(request.originalRequest.URL?.absoluteString, "https://api.twitter.com/1.1/statuses/home_timeline.json")
        XCTAssertEqual(request.originalRequest.HTTPMethod, "GET")
    }
    
    func testPOST() {
        let client = OAuthClient(consumerKey: "hoge", consumerSecret: "foo", accessToken: "bar", accessTokenSecret: "baz")
        let request = client.post("https://api.twitter.com/1.1/statuses/home_timeline.json")
        XCTAssertEqual(request.originalRequest.HTTPMethod, "POST")
    }
    
    func testStreaming() {
        let client = OAuthClient(consumerKey: "hoge", consumerSecret: "foo", accessToken: "bar", accessTokenSecret: "baz")
        let request = client.streaming("https://userstream.twitter.com/1.1/user.json")
        XCTAssertEqual(request.request.URL?.absoluteString, "https://userstream.twitter.com/1.1/user.json")
        XCTAssertEqual(request.request.HTTPMethod, "GET")
    }
    
    func testGETWithParameters() {
        let client = OAuthClient(consumerKey: "hoge", consumerSecret: "foo", accessToken: "bar", accessTokenSecret: "baz")
        let request = client.get("https://api.twitter.com/1.1/statuses/home_timeline.json", parameters: ["count": "200"])
        XCTAssertEqual(request.originalRequest.URL?.absoluteString, "https://api.twitter.com/1.1/statuses/home_timeline.json?count=200")
        XCTAssertEqual(request.originalRequest.URL?.query, "count=200")
        XCTAssertEqual(request.originalRequest.HTTPMethod, "GET")
    }
    
    func testPOSTWithParameters() {
        let client = OAuthClient(consumerKey: "hoge", consumerSecret: "foo", accessToken: "bar", accessTokenSecret: "baz")
        let request = client.post("https://api.twitter.com/1.1/statuses/update.json", parameters: ["status": "test"])
        XCTAssertEqual(request.originalRequest.URL?.absoluteString, "https://api.twitter.com/1.1/statuses/update.json")
        XCTAssertEqual(NSString(data: request.originalRequest.HTTPBody!, encoding: NSUTF8StringEncoding), "status=test")
        XCTAssertEqual(request.originalRequest.HTTPMethod, "POST")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
