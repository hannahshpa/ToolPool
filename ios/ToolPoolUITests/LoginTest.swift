//
//  LoginTest.swift
//  ToolPoolUITests
//
//  Created by Olsen on 12/3/20.
//

import XCTest

class LoginTest: XCTestCase {

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

    func testSignIn() throws {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      let app = XCUIApplication()
      app.launch()
      app.buttons["Sign In"].tap()
      
      let tablesQuery = app.tables
      let emailTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells[\"Email\"].textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      emailTextField.tap()
      emailTextField.tap()
      emailTextField.typeText("joe.bruin@ucla.edu")
      
      let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
      passwordTextField.tap()
      passwordTextField.tap()
      passwordTextField.typeText("password")
      
      app.buttons["Enter"].tap()
      
    }
  
  func testAddTool() throws {

    let app = XCUIApplication()
    app.buttons["Sign In"].tap()
    
    let tablesQuery2 = app.tables
    let tablesQuery = tablesQuery2
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
    toolNameTextField.typeText("New Hammer")
    
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
    tablesQuery2.cells["Hand Tools"].children(matching: .other).element(boundBy: 0).tap()
    
    //tablesQuery/*@START_MENU_TOKEN@*/.textFields["Description"]/*[[".cells.textFields[\"Description\"]",".textFields[\"Description\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    tablesQuery2.cells["Condition"].otherElements.containing(.button, identifier:"Condition").element.tap()
    
    tablesQuery2.cells["Good"].children(matching: .other).element(boundBy: 0).tap()
    tablesQuery/*@START_MENU_TOKEN@*/.buttons["Photo library"]/*[[".cells[\"Photo library\"].buttons[\"Photo library\"]",".buttons[\"Photo library\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    app.scrollViews.otherElements.images["Photo, March 12, 2011, 4:17 PM"].tap()
    
    app.buttons["Submit Tool"].tap()
    //app.buttons["Submit Tool"].swipeUp()

    //sleep(5)
    
  // let scrollViewsQuery = app.scrollViews
    //scrollViewsQuery.children(matching: .button).element(boundBy: 1).tap()
    let elementsQuery = app.scrollViews.otherElements
    elementsQuery.buttons["New Hammer"].tap()
    app/*@START_MENU_TOKEN@*/.buttons["Back To My Toolbox"]/*[[".scrollViews.buttons[\"Back To My Toolbox\"]",".buttons[\"Back To My Toolbox\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    
  }

  /*
  func testGrid() throws {
    
    let app = XCUIApplication()
    app/*@START_MENU_TOKEN@*/.tables.containing(.cell, identifier:"Email").element/*[[".tables.containing(.cell, identifier:\"Password\").element",".tables.containing(.cell, identifier:\"Email\").element"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    let tablesQuery = app.tables
    tablesQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells[\"Email\"].textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    passwordTextField.tap()
    passwordTextField.tap()
    app.buttons["Enter"].tap()
    app.buttons["Add New Tool"].tap()
    
    let toolNameTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Tool Name"]/*[[".cells[\"Tool Name\"].textFields[\"Tool Name\"]",".textFields[\"Tool Name\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    toolNameTextField.tap()
    toolNameTextField.tap()
    tablesQuery/*@START_MENU_TOKEN@*/.textFields["Cost Per Hour"]/*[[".cells[\"Cost Per Hour\"].textFields[\"Cost Per Hour\"]",".textFields[\"Cost Per Hour\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    tablesQuery/*@START_MENU_TOKEN@*/.buttons["Photo library"]/*[[".cells[\"Photo library\"].buttons[\"Photo library\"]",".buttons[\"Photo library\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    let scrollViewsQuery = app.scrollViews
    scrollViewsQuery.otherElements.images["Photo, November 29, 12:42 PM"].tap()
    
    let toolNameTable = app/*@START_MENU_TOKEN@*/.tables.containing(.cell, identifier:"Tool Name").element/*[[".tables.containing(.cell, identifier:\"Photo library\").element",".tables.containing(.cell, identifier:\"Condition\").element",".tables.containing(.cell, identifier:\"Category\").element",".tables.containing(.cell, identifier:\"Description\").element",".tables.containing(.cell, identifier:\"Tool Name\").element"],[[[-1,4],[-1,3],[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    toolNameTable.tap()
    toolNameTable.tap()
    scrollViewsQuery.children(matching: .button).element(boundBy: 1).tap()
    app/*@START_MENU_TOKEN@*/.buttons["Back To My Toolbox"]/*[[".scrollViews.buttons[\"Back To My Toolbox\"]",".buttons[\"Back To My Toolbox\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    let app = XCUIApplication()
    app.buttons["Sign In"].tap()
    
    let tablesQuery = app.tables
    tablesQuery/*@START_MENU_TOKEN@*/.textFields["Email"]/*[[".cells[\"Email\"].textFields[\"Email\"]",".textFields[\"Email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    let passwordTextField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["Password"]/*[[".cells[\"Password\"].textFields[\"Password\"]",".textFields[\"Password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
    passwordTextField.tap()
    passwordTextField.tap()
    app.buttons["Enter"].tap()
    app.buttons["Add New Tool"].tap()
    app.buttons["Submit Tool"].swipeUp()
    
  }*/
}
