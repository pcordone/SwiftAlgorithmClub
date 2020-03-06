import XCTest
@testable import swift_algorithm_club

final class swift_algorithm_clubTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(swift_algorithm_club().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
