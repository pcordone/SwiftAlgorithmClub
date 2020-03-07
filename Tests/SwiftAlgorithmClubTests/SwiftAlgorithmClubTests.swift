import XCTest
@testable import SwiftAlgorithmClub

final class SwiftAlgorithmClubTests: XCTestCase {
    private var now: Date!
    private var nowMinusOneSec: Date!
    private var nowPlusOneSec: Date!
    
    override func setUp() {
        now = Date(timeIntervalSinceReferenceDate: 0)
        nowMinusOneSec = now.addingTimeInterval(-1)
        nowPlusOneSec = now.addingTimeInterval(1)
    }
    
    func testOrderedArrayInsert() {
        var array = OrderedArray<Date>(array: [])
        XCTAssertEqual(0, array.insert(now))
        XCTAssertEqual(1, array.count)
        XCTAssertEqual(now, array[0])
        XCTAssertEqual(0, array.insert(nowMinusOneSec))
        XCTAssertEqual(2, array.count)
        XCTAssertEqual(nowMinusOneSec, array[0])
        XCTAssertEqual(now, array[1])
        XCTAssertEqual(2, array.insert(nowPlusOneSec))
        XCTAssertEqual(3, array.count)
        XCTAssertEqual(nowPlusOneSec, array[2])
    }
    
    func testOrderedArrayMatchingOrPreviousToEntry() {
        XCTAssertNotNil(now)
        XCTAssertNotNil(nowPlusOneSec)
        XCTAssertNotNil(nowMinusOneSec)
        var array = OrderedArray<Date>(array: [])
        let nowMinusTwoSec = now.addingTimeInterval(-2)
        let nowMinusThreeSec = now.addingTimeInterval(-3)
        let nowPlusTwoSec = now.addingTimeInterval(+2)
        XCTAssertEqual(0, array.insert(nowPlusTwoSec))
        XCTAssertEqual(0, array.insert(nowMinusTwoSec))
        XCTAssertEqual(1, array.insert(now))
        XCTAssertEqual(now, array.matchingOrPreviousToEntry(now))
        XCTAssertEqual(nowMinusTwoSec, array.matchingOrPreviousToEntry(nowMinusOneSec))
        XCTAssertNil(array.matchingOrPreviousToEntry(nowMinusThreeSec))
        XCTAssertEqual(nowMinusTwoSec, array.matchingOrPreviousToEntry(nowMinusTwoSec))
    }
    
    func testOrderedArrayMatchingOrLaterToEntry() {
        var array = OrderedArray<Date>(array: [])
        let nowMinusTwoSec = now.addingTimeInterval(-2)
        let nowPlusTwoSec = now.addingTimeInterval(+2)
        let nowPlusThreeSec = now.addingTimeInterval(+3)
        XCTAssertEqual(0, array.insert(nowPlusTwoSec))
        XCTAssertEqual(0, array.insert(nowMinusTwoSec))
        XCTAssertEqual(1, array.insert(now))
        XCTAssertEqual(now, array.matchingOrLaterThanEntry(now))
        XCTAssertEqual(nowPlusTwoSec, array.matchingOrLaterThanEntry(nowPlusOneSec))
        XCTAssertNil(array.matchingOrLaterThanEntry(nowPlusThreeSec))
        XCTAssertEqual(nowPlusTwoSec, array.matchingOrLaterThanEntry(nowPlusTwoSec))
    }

    static var allTests = [
        ("testOrderedArray", testOrderedArrayInsert),
        ("testOrderedArrayMatchingOrPreviousToEntry", testOrderedArrayMatchingOrPreviousToEntry),
    ]
}
