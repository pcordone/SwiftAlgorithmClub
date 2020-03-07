import XCTest
@testable import SwiftAlgorithmClub

final class SwiftAlgorithmClubTests: XCTestCase {
    private var now: Date!
    private var nowMinusOneSec: Date!
    private var nowPlusOneSec: Date!
    private var array: OrderedArray<Date>!
    
    override func setUp() {
        array = OrderedArray<Date>(array: [])
        now = Date(timeIntervalSinceReferenceDate: 0)
        nowMinusOneSec = now.addingTimeInterval(-1)
        nowPlusOneSec = now.addingTimeInterval(1)
    }
    
    func testCount() {
        XCTAssertEqual(0, array.count)
    }
    
    func testOrderedArrayInsert() {
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
    
    func testIsEmpty() {
        XCTAssertTrue(array.isEmpty)
        XCTAssertEqual(0, array.insert(now))
        XCTAssertFalse(array.isEmpty)
    }
    
    func testRemoveAtIndex() {
        XCTAssertEqual(0, array.insert(now))
        XCTAssertEqual(1, array.count)
        XCTAssertEqual(now, array.removeAtIndex(0))
        XCTAssertEqual(0, array.count)
    }
    
    func testOrderedArrayRemove() {
        XCTAssertEqual(0, array.insert(nowMinusOneSec))
        XCTAssertEqual(1, array.insert(now))
        XCTAssertEqual(2, array.insert(nowPlusOneSec))
        XCTAssertEqual(3, array.count)
        XCTAssertEqual(now, array.remove(now))
        XCTAssertEqual(2, array.count)
    }
    
    func testRemoveAll() {
        XCTAssertTrue(array.isEmpty)
        array.removeAll()
        XCTAssertTrue(array.isEmpty)
        XCTAssertEqual(0, array.insert(now))
        array.removeAll()
        XCTAssertTrue(array.isEmpty)
        XCTAssertEqual(0, array.insert(nowMinusOneSec))
        XCTAssertEqual(1, array.insert(now))
        XCTAssertEqual(2, array.count)
        array.removeAll()
        XCTAssertTrue(array.isEmpty)
    }
    
    func testOrderedArrayMatchingOrPreviousToEntry() {
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
        ("testCount", testCount),
        ("testOrderedArrayInsert", testOrderedArrayInsert),
        ("testIsEmpty", testIsEmpty),
        ("testRemoveAtIndex", testRemoveAtIndex),
        ("testOrderedArrayRemove", testOrderedArrayRemove),
        ("testRemoveAll", testRemoveAll),
        ("testOrderedArrayMatchingOrPreviousToEntry", testOrderedArrayMatchingOrPreviousToEntry),
        ("testOrderedArrayMatchingOrLaterToEntry", testOrderedArrayMatchingOrLaterToEntry),
        ("testOrderedArrayRemove", testOrderedArrayRemove),
    ]
}
