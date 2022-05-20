//
//  Test_SeifUITests.swift
//  Test SeifUITests
//
//  Created by  Seif on 19/05/2022.
//

import XCTest

class Test_SeifUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        //Search for the first textfield on the screen
        let textField = app.textFields.firstMatch
        textField.tap()
        textField.typeText("English Premier League")
        //Dismiss the keyboard
        textField.typeText("\n")
        //A brief waiting time to make sure the API has returned the result
        sleep(2)
        //Click on the first team on the collectionView
        let firstTeam = app.collectionViews.children(matching:.any).element(boundBy: 0)
        if firstTeam.exists {
            firstTeam.tap()
        }
        //Check if it is Arsenal
        XCTAssert(app.navigationBars["Arsenal"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
