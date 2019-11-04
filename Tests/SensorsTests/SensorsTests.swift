import XCTest
@testable import Sensors

final class SensorsTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Sensors().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
