//
//  BorrowTest.swift
//  ToolPoolUITests
//
//  Created by Olsen on 12/4/20.
//

import XCTest

class BorrowTest: XCTestCase {

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

    func testBorrowingTab() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      
      let app = XCUIApplication()
      app.buttons["Sign In"].tap()
      
      let tablesQuery2 = app.tables
      let tablesQuery = tablesQuery2
      let emailTextField = tablesQuery.textFields["Email"]
      emailTextField.tap()
      emailTextField.tap()
      emailTextField.typeText("john@example.com")
      
      tablesQuery2.cells["Password"].otherElements.containing(.textField, identifier:"Password").element.tap()
      
      let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      passwordTextField.tap()
      passwordTextField.tap()
      passwordTextField.typeText("password")
      passwordTextField.typeText("\n")
      
      app.buttons["Enter"].tap()
      app.tabBars["Tab Bar"].buttons["wrench"].tap()
      tablesQuery/*@START_MENU_TOKEN@*/.buttons["Sunday, November 8, 2020 at 6:30:00 AM Pacific Standard Time : Blender"]/*[[".cells[\"Sunday, November 8, 2020 at 6:30:00 AM Pacific Standard Time : Blender\"].buttons[\"Sunday, November 8, 2020 at 6:30:00 AM Pacific Standard Time : Blender\"]",".buttons[\"Sunday, November 8, 2020 at 6:30:00 AM Pacific Standard Time : Blender\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      
    
      
    }

}
