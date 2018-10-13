//
//  Github_BrowserUITests.swift
//  Github BrowserUITests
//
//  Created by Gustavo Severo on 11/10/2018.
//  Copyright © 2018 Gustavo Severo. All rights reserved.
//

import XCTest

let kTimeout: TimeInterval = 15
let kReaction: TimeInterval = 10

class Github_BrowserUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {}

    func testSearchNotAvailableLanguage() {
        app.tables.searchFields["Language"].clearAndEnterText(text: "Eu não existo")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: kTimeout)
        XCTAssert(app.staticTexts["😔"].exists)
    }
    
    func testSearchSwiftLanguage() {
        app.tables.searchFields["Language"].clearAndEnterText(text: "Swift")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: kTimeout)
        XCTAssert(!app.staticTexts["😔"].exists)
    }
    
    func testSearchSwiftLanguageWithFirstRepositoryTap() {
        app.tables.searchFields["Language"].clearAndEnterText(text: "Swift")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: kTimeout)
        XCTAssert(!app.staticTexts["😔"].exists)
        app.tables.cells.firstMatch.tap()
    }
    
    func testSearchSwiftLanguageWithFirstRepositoryTapAndReadmeSee() {
        app.tables.searchFields["Language"].clearAndEnterText(text: "Swift")
        app/*@START_MENU_TOKEN@*/.buttons["Search"]/*[[".keyboards.buttons[\"Search\"]",".buttons[\"Search\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        wait(for: kTimeout)
        XCTAssert(!app.staticTexts["😔"].exists)
        app.tables.cells.firstMatch.tap()
        wait(for: kReaction)
        XCTAssert(app.webViews.firstMatch.exists)
    }
}
