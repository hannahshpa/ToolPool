//
//  LoginTests.swift
//  ToolPoolUITests
//
//  Created by Olsen on 11/28/20.
//

import XCTest

class LoginTests: XCTestCase {

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
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      let app = XCUIApplication()
      app.buttons["Sign In"].tap()
      
      let tablesQuery2 = app.tables
      let tablesQuery = tablesQuery2
      tablesQuery/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".cells[\"Username\"].textFields[\"Username\"]",".textFields[\"Username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery/*@START_MENU_TOKEN@*/.textFields["Username"]/*[[".cells[\"Username\"].textFields[\"Username\"]",".textFields[\"Username\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Test")
      
      let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      passwordTextField.tap()
      passwordTextField.tap()
      passwordTextField.typeText("Test")
      app.buttons["Enter"].tap()
      
      //let app2 = app
      //app2/*@START_MENU_TOKEN@*/.buttons["Hammer"]/*[[".scrollViews.buttons[\"Hammer\"]",".buttons[\"Hammer\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      //app2/*@START_MENU_TOKEN@*/.buttons["Back To My Toolbox"]/*[[".scrollViews.buttons[\"Back To My Toolbox\"]",".buttons[\"Back To My Toolbox\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      app.buttons["Add New Tool"].tap()
      
      let toolNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Tool Name"]/*[[".cells[\"Tool Name\"].textFields[\"Tool Name\"]",".textFields[\"Tool Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      toolNameTextField.tap()
      toolNameTextField.tap()
      toolNameTextField.typeText("Hammer")
      
      let costPerHourTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Cost Per Hour"]/*[[".cells[\"Cost Per Hour\"].textFields[\"Cost Per Hour\"]",".textFields[\"Cost Per Hour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      costPerHourTextField.tap()
      costPerHourTextField.tap()
      costPerHourTextField.typeText("5")
      
      let descriptionTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Description"]/*[[".cells[\"Description\"].textFields[\"Description\"]",".textFields[\"Description\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      descriptionTextField.tap()
      descriptionTextField.tap()
      descriptionTextField.typeText("this is a test")
      
      tablesQuery2.cells["Category"].otherElements.containing(.button, identifier:"Category").element.tap()
      tablesQuery2.cells["Gardening"].children(matching: .other).element(boundBy: 0).tap()
      
      //tablesQuery/*@START_MENU_TOKEN@*/.textFields["Description"]/*[[".cells.textFields[\"Description\"]",".textFields[\"Description\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery/*@START_MENU_TOKEN@*/.textFields["Longitude"]/*[[".cells[\"Longitude\"].textFields[\"Longitude\"]",".textFields[\"Longitude\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery/*@START_MENU_TOKEN@*/.textFields["Longitude"]/*[[".cells[\"Longitude\"].textFields[\"Longitude\"]",".textFields[\"Longitude\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("10")
      
      let latitudeTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Latitude"]/*[[".cells[\"Latitude\"].textFields[\"Latitude\"]",".textFields[\"Latitude\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      latitudeTextField.tap()
      latitudeTextField.tap()
      latitudeTextField.typeText("10")
      
      
      tablesQuery2.staticTexts["CONDITION"].tap()
      tablesQuery/*@START_MENU_TOKEN@*/.buttons["Condition"]/*[[".cells[\"Condition\"].buttons[\"Condition\"]",".buttons[\"Condition\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery2.cells["Good"].children(matching: .other).element(boundBy: 0).tap()
      
      tablesQuery/*@START_MENU_TOKEN@*/.textFields["Latitude"]/*[[".cells.textFields[\"Latitude\"]",".textFields[\"Latitude\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      tablesQuery/*@START_MENU_TOKEN@*/.buttons["Photo library"]/*[[".cells[\"Photo library\"].buttons[\"Photo library\"]",".buttons[\"Photo library\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      app.scrollViews.otherElements.images["Photo, March 30, 2018, 12:14 PM"].tap()
      tablesQuery2.cells["Photo library"].otherElements.containing(.button, identifier:"Photo library").element.swipeUp()
      
      
      
    }

}
