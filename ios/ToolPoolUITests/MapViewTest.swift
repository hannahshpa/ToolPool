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

    func testDirectionsToToolTest() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // if app doesn't crash at the end then apple maps did not return a nil
        let app2 = XCUIApplication()
        let app = app2
        app.buttons["Sign In"].tap()
        
        let tablesQuery = app2.tables
        let emailTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells[\"Email\"].textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        emailTextField.tap()
        emailTextField.tap()
        emailTextField.typeText("joe.bruin@ucla.edu")
   
        
        let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        passwordTextField.tap()
        passwordTextField.tap()
        passwordTextField.typeText("password")

        app.buttons["Enter"].tap()
        app.buttons["Add New Tool"].tap()
        
        let toolNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Tool Name"]/*[[".cells[\"Tool Name\"].textFields[\"Tool Name\"]",".textFields[\"Tool Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        toolNameTextField.tap()
        toolNameTextField.tap()
        toolNameTextField.typeText("Tent2")
        
        let costPerHourTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Cost Per Hour"]/*[[".cells[\"Cost Per Hour\"].textFields[\"Cost Per Hour\"]",".textFields[\"Cost Per Hour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        costPerHourTextField.tap()
        costPerHourTextField.tap()
        costPerHourTextField.typeText("15")
        
        let descriptionTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Description"]/*[[".cells[\"Description\"].textFields[\"Description\"]",".textFields[\"Description\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        descriptionTextField.tap()
        descriptionTextField.tap()
        descriptionTextField.typeText("Medium sized steel hammer")
        descriptionTextField.typeText("\n")
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Category"]/*[[".cells[\"Category\"].buttons[\"Category\"]",".buttons[\"Category\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Camping"]/*[[".cells[\"Camping\"].buttons[\"Camping\"]",".buttons[\"Camping\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Condition"]/*[[".cells[\"Condition\"].buttons[\"Condition\"]",".buttons[\"Condition\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let tablesQuery2 = app.tables
        tablesQuery2.cells["Good"].children(matching: .other).element(boundBy: 0).tap()
        tablesQuery2.staticTexts["IMAGES"]/*@START_MENU_TOKEN@*/.swipeRight()/*[[".swipeUp()",".swipeRight()"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Photo library"]/*[[".cells[\"Photo library\"].buttons[\"Photo library\"]",".buttons[\"Photo library\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.scrollViews.otherElements.images["Photo, March 12, 2011, 4:17 PM"].tap()
        app/*@START_MENU_TOKEN@*/.tables.containing(.cell, identifier:"Category").element/*[[".tables.containing(.cell, identifier:\"Photo library\").element",".tables.containing(.cell, identifier:\"Good\").element",".tables.containing(.cell, identifier:\"Category\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Submit Tool"].swipeUp()
        app.tabBars["Tab Bar"].buttons["magnifyingglass"].tap()
        app2/*@START_MENU_TOKEN@*/.buttons["Camping"]/*[[".scrollViews.buttons[\"Camping\"]",".buttons[\"Camping\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app2.buttons["Tent2"].tap()
                app2/*@START_MENU_TOKEN@*/.buttons["Get Directions To Tool"]/*[[".scrollViews.buttons[\"Get Directions To Tool\"]",".buttons[\"Get Directions To Tool\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        

    }

}
