//
//  MapViewTest.swift
//  ToolPoolUITests
//
//  Created by Giovanni Moya on 12/2/20.
//
import SwiftUI
import MapKit
import XCTest

class MapViewTest: XCTestCase {
    @ObservedObject var locationManager = LocationManager()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
//    func testDownloadWebData() {
//
//        // Create an expectation for a background download task.
//        let expectation = XCTestExpectation(description: "Download apple.com home page")
//
//        // Create a URL for a web page to be downloaded.
//        let url = URL(string: "https://apple.com")!
//
//        // Create a background task to download the web page.
//        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
//
//            // Make sure we downloaded some data.
//            XCTAssertNotNil(data, "No data was downloaded.")
//
//            // Fulfill the expectation to indicate that the background task has finished successfully.
//            expectation.fulfill()
//
//        }
//
//        // Start the download task.
//        dataTask.resume()
//
//        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
//        wait(for: [expectation], timeout: 10.0)
//    }
    
    // this is a completion to ensure latitude and longitude is initialized! :)
    func testGetLocation() {
        
        let expectation = XCTestExpectation(description: "get user location from device")
        
        locationManager.getUserLocation { (lat, lng) in
            
            guard let latitude = Double(lat) else {
                XCTAssertNotNil(lat, "No latitude was found.")
                return
            }
            guard let longitude = Double(lng) else {
                XCTAssertNotNil(lng, "No longitude was found.")
                return
            }
            
            
            if latitude != nil {
                XCTAssert(latitude >= -90 && Double(lat)! <= 90)
            }
                
            if longitude != nil {
                XCTAssert(longitude >= -180 && Double(lat)! <= 180)
            }
                
            // Fulfill the expectation to indicate that the background task has finished successfully.
            expectation.fulfill()
            
        }
        // Wait until the expectation is fulfilled, with a timeout of 10 seconds.
        wait(for: [expectation], timeout: 10.0)
    }

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.buttons["Sign In"].tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".cells[\"Username\"].textFields[\"Username\"]",".textFields[\"Username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Enter"].tap()
        app.tabBars["Tab Bar"].buttons["magnifyingglass"].tap()
        //test that device found user location
        testGetLocation()
        app/*@START_MENU_TOKEN@*/.buttons["Camping"]/*[[".scrollViews.buttons[\"Camping\"]",".buttons[\"Camping\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Power chisel"]/*[[".scrollViews.buttons[\"Power chisel\"]",".buttons[\"Power chisel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Get Directions To Tool"]/*[[".scrollViews.buttons[\"Get Directions To Tool\"]",".buttons[\"Get Directions To Tool\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        //check tha
    }

}
