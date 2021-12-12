//
//  SetGameUITests.swift
//  SetGameUITests
//
//  Created by Yousef Zuriqi on 05/12/2021.
//

import XCTest

class SetGameUITests: XCTestCase {
    var app: XCUIApplication!


    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
        try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDealCardButtonIsDisabledAfterFourTimesHit() {
       
        // given
        let dealCardButton = app.buttons["Deal Cards"]

        // when
        app.buttons["Deal Cards"].tap()
        app.buttons["Deal Cards"].tap()
        app.buttons["Deal Cards"].tap()
        app.buttons["Deal Cards"].tap()

        // then
        XCTAssertFalse(dealCardButton.isEnabled)
    }
    
    func testNewGameButtonTapped() {
        // given
        let newGameButton = app.buttons["New Game"]
        let element2 = XCUIApplication().windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0)
        let element = element2.children(matching: .other).element(boundBy: 3)
        let element3 = element2.children(matching: .other).element(boundBy: 4)
        let element4 = element2.children(matching: .other).element(boundBy: 5)
        
        // when
        newGameButton.tap()
        
        // then
        XCTAssertTrue(element2.title == "" )
        XCTAssertTrue(element3.title == "" )
        XCTAssertTrue(element4.title == "" )
        XCTAssertTrue(element.title == "" )
    }
    
}
