//
//  SearchTabTest.swift
//  ToolPoolUITests
//
//  Created by Hannah Park on 12/3/20.
//

import XCTest

class SearchTabTest: XCTestCase {

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

    func testExample() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results
        let app = XCUIApplication()
        app.buttons["Sign In"].tap()
        
        let tablesQuery2 = app.tables
        let tablesQuery = tablesQuery2
        
        let usernameTextField = tablesQuery.textFields["Email"]
        usernameTextField.tap()
        usernameTextField.typeText("jane@example.org")

        let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        passwordTextField.tap()
        passwordTextField.typeText("password")
        app.buttons["Enter"].tap()
        
        app.buttons["Add New Tool"].tap()
        
        let toolNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Tool Name"]/*[[".cells[\"Tool Name\"].textFields[\"Tool Name\"]",".textFields[\"Tool Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        toolNameTextField.tap()
        toolNameTextField.tap()
        toolNameTextField.typeText("Test Blender")
        
        let costPerHourTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Cost Per Hour"]/*[[".cells[\"Cost Per Hour\"].textFields[\"Cost Per Hour\"]",".textFields[\"Cost Per Hour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        costPerHourTextField.tap()
        costPerHourTextField.tap()
        costPerHourTextField.typeText("15")
        
        let descriptionTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Description"]/*[[".cells[\"Description\"].textFields[\"Description\"]",".textFields[\"Description\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        descriptionTextField.tap()
        descriptionTextField.tap()
        descriptionTextField.typeText("Medium sized blender")
        descriptionTextField.typeText("\n")
        
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Category"]/*[[".cells[\"Category\"].buttons[\"Category\"]",".buttons[\"Category\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2.cells["Kitchen"].children(matching: .other).element(boundBy: 0).tap()
        
        //tablesQuery/*@START_MENU_TOKEN@*/.textFields["Description"]/*[[".cells.textFields[\"Description\"]",".textFields[\"Description\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        tablesQuery2.cells["Condition"].otherElements.containing(.button, identifier:"Condition").element.tap()
        
        tablesQuery2.cells["Good"].children(matching: .other).element(boundBy: 0).tap()
        tablesQuery2/*@START_MENU_TOKEN@*/.buttons["Photo library"]/*[[".cells[\"Photo library\"].buttons[\"Photo library\"]",".buttons[\"Photo library\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
            app.scrollViews.otherElements.images["Photo, March 12, 2011, 4:17 PM"].tap()

         //app.scrollViews.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .image).matching(identifier: "Photo, December 02, 8:22 PM").element(boundBy: 1).tap()
       //  app/*@START_MENU_TOKEN@*/.tables.containing(.cell, identifier:"Hand Tools").element/*[[".tables.containing(.cell, identifier:\"Photo library\").element",".tables.containing(.cell, identifier:\"Good\").element",".tables.containing(.cell, identifier:\"Hand Tools\").element"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.buttons["Submit Tool"].tap()
        //app.buttons["Submit Tool"].swipeUp()

        //sleep(5)
        /*
        let scrollViewsQuery = app.scrollViews
        scrollViewsQuery.children(matching: .button).element(boundBy: 1).tap()
        app/*@START_MENU_TOKEN@*/.buttons["Back To My Toolbox"]/*[[".scrollViews.buttons[\"Back To My Toolbox\"]",".buttons[\"Back To My Toolbox\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        */
        app.tabBars["Tab Bar"].buttons["Search"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.buttons["Kitchen"].tap()
        elementsQuery.buttons["Test Blender"].tap()
        elementsQuery.datePickers["Start Date"].buttons["Month"].swipeUp()
        elementsQuery.buttons["Set Reservation Details"].tap()
        app.buttons["Request Reservation"].tap()
        
    }

}
