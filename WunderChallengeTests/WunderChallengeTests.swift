//
//  WunderChallengeTests.swift
//  WunderChallengeTests
//
//  Created by Mohab Ayman on 9/29/19.
//  Copyright © 2019 Mohab Ayman. All rights reserved.
//

import XCTest
import SwiftyJSON
//import MBProgressHUD

@testable import WunderChallenge

class WunderChallengeTests: XCTestCase {
    
    
    let newjson: [String: Any] = [
        "address": "Lesserstraße 170, 22049 Hamburg",
        "coordinates": [10.07526, 53.59301, 0],
        "engineType": "CE",
        "exterior": "UNACCEPTABLE",
        "fuel": 42,
        "interior": "UNACCEPTABLE",
        "name": "HH-GO8522",
        "vin": "WME4513341K565439"
    ]
    
    let json_error = JSON("asdadnansad")
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testJSONParsing() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        XCTAssertThrowsError(try Car(dictionary: json_error))
        
        let car = try! Car(dictionary: JSON(newjson))
        
        XCTAssertEqual(car.address, "Lesserstraße 170, 22049 Hamburg", "address computed is wrong")
        XCTAssertEqual(car.coordinates[0], 10.07526, "coordinates[0] computed is wrong")
        XCTAssertEqual(car.coordinates[1], 53.59301, "coordinates[1] computed is wrong")
        XCTAssertEqual(car.coordinates[2], 0, "coordinates[2] computed is wrong")
        XCTAssertEqual(car.engineType, "CE", "engineType computed is wrong")
        XCTAssertEqual(car.exterior, "UNACCEPTABLE", "exterior computed is wrong")
        XCTAssertEqual(car.fuel, 42, "fuel computed is wrong")
        XCTAssertEqual(car.interior, "UNACCEPTABLE", "interior computed is wrong")
        XCTAssertEqual(car.name, "HH-GO8522", "Name computed is wrong")
        XCTAssertEqual(car.vin, "WME4513341K565439", "vin computed is wrong")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
