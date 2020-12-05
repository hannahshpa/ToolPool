//
//  LoginTests.swift
//  ToolPoolUITests
//
//  Created by Olsen on 11/28/20.
//

import XCTest

class CreateAccountTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        //XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreatingAccount() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      
      let app = XCUIApplication()
      app.launch()
      
      app.buttons["Create Account"].tap()
      
      let tablesQuery = app.tables
      let emailTextField  = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells[\"Email\"].textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      emailTextField.tap()
      emailTextField.tap()
      emailTextField.typeText("joe.bruin@ucla.edu")
      
      let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      passwordTextField.tap()
      passwordTextField.tap()
      passwordTextField.typeText("password")
      
      let nameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Name"]/*[[".cells[\"Name\"].textFields[\"Name\"]",".textFields[\"Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      nameTextField.tap()
      nameTextField.tap()
      nameTextField.typeText("Joe")
      
      let phoneNumberTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Phone Number"]/*[[".cells[\"Phone Number\"].textFields[\"Phone Number\"]",".textFields[\"Phone Number\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      phoneNumberTextField.tap()
      phoneNumberTextField.tap()
      phoneNumberTextField.typeText("123456789")
      
      phoneNumberTextField.typeText("\n")
      
      tablesQuery/*@START_MENU_TOKEN@*/.buttons["Photo library"]/*[[".cells[\"Photo library\"].buttons[\"Photo library\"]",".buttons[\"Photo library\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
      app.scrollViews.otherElements.images["Photo, October 09, 2009, 2:09 PM"].tap()
      
      app.buttons["Enter"].tap()
      
    }

}
