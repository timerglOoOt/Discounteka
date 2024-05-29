import XCTest

final class DiscountUITests: XCTestCase {
    var app: XCUIApplication!
    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testButtonExist() throws {
        let button = app.buttons["signUp"]
        XCTAssertTrue(button.exists, "Кнопка должна существовать на экране")
        button.tap()
    }

    func testTextFieldIsEnabled() throws {
        let textField = app.textFields["email"]
        XCTAssertTrue(textField.exists, "Текстовое поле должно существовать на экране")
        textField.tap()
        XCTAssertTrue(textField.isEnabled, "Текстовое поле должно быть выбрано")
    }

//    func testLightTheme() throws {
//        let screenshot = app.screenshot()
//        let attachment = XCTAttachment(screenshot: screenshot)
//        attachment.name = "Light Theme Screenshot"
//        attachment.lifetime = .keepAlways
//        add(attachment)
//    }

    func testDarkTheme() throws {
        let screenshot = app.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = "Dark Theme Screenshot"
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    func testTextFieldNextAndDone() throws {
        app/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"Имя\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.textFields["lastName"]/*[[".textFields[\"Фамилия\"]",".textFields[\"lastName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.textFields["email"]/*[[".textFields[\"Почта\"]",".textFields[\"email\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.secureTextFields["Пароль"].tap()
    }
}
