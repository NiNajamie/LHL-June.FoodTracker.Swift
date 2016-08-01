//
//  LHL_June_FoodTracker_SwiftTests.swift
//  LHL-June.FoodTracker.SwiftTests
//
//  Created by Asuka Nakagawa on 2016-07-31.
//  Copyright © 2016 Asuka Nakagawa. All rights reserved.
//

import UIKit
import XCTest
@testable import LHL_June_FoodTracker_Swift

class LHL_June_FoodTracker_SwiftTests: XCTestCase {
    
    // MARK: FoodTracker Tests
    
    // Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
    func testMealInitialization() {
        
        // Success case.
        let potentialItem = Meal(name: "NewestMeal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "EmptyName is invalid")
        
        let badRating = Meal(name: "Really Bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative Ratings are invalid, be positive.")
    }
    
    
    
    
    
//    override func setUp() {
//        super.setUp()
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//    
//    override func tearDown() {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//        super.tearDown()
//    }
//    
//    func testExample() {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//    }
//    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
