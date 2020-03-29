import XCTest
@testable import SwiftAlgorithmClub

final class SwiftAlgorithmClubTests: XCTestCase {
    private var now: Date!
    private var nowMinusOneSec: Date!
    private var nowPlusOneSec: Date!
    private var array: OrderedArray<Date>!

    func assertTuplesEqual<F:Equatable, S:Equatable>(
            actual: (_: F, _: S),
            expected: (_: F, _: S),
            file: StaticString = #file, line: UInt = #line) {
        if actual != expected {
            XCTFail("Expected \(expected) but was \(actual)",
                    file: file, line: line)
        }
    }
    
    override func setUp() {
        array = OrderedArray<Date>(array: [])
        now = Date(timeIntervalSinceReferenceDate: 0)
        nowMinusOneSec = now.addingTimeInterval(-1)
        nowPlusOneSec = now.addingTimeInterval(1)
    }
    
    func testInitNoArgs() {
        array = OrderedArray<Date>()
        XCTAssertEqual(0, array.count)
    }
    
    func testCount() {
        XCTAssertEqual(0, array.count)
    }
    
    func testOrderedArrayInsertAllowDuplicates() {
        assertTuplesEqual(actual: (false, 0), expected: array.insert(now))
        XCTAssertEqual(1, array.count)
        XCTAssertEqual(now, array[0])
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowMinusOneSec))
        XCTAssertEqual(2, array.count)
        XCTAssertEqual(nowMinusOneSec, array[0])
        XCTAssertEqual(now, array[1])
        assertTuplesEqual(actual: (false, 2), expected: array.insert(nowPlusOneSec))
        XCTAssertEqual(3, array.count)
        XCTAssertEqual(nowPlusOneSec, array[2])
    }
    
    func testOrderedArrayInsertDontAllowDuplicates() {
        assertTuplesEqual(actual: (false, 0), expected: array.insert(now))
        assertTuplesEqual(actual: (true, 0), expected: array.insert(now))
    }
        
    func testIsEmpty() {
        XCTAssertTrue(array.isEmpty)
        assertTuplesEqual(actual: (false, 0), expected: array.insert(now))
        XCTAssertFalse(array.isEmpty)
    }
    
    func testRemoveAtIndex() {
        assertTuplesEqual(actual: (false, 0), expected: array.insert(now))
        XCTAssertEqual(1, array.count)
        XCTAssertEqual(now, array.removeAtIndex(0))
        XCTAssertEqual(0, array.count)
    }
    
    func testOrderedArrayRemove() {
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowMinusOneSec))
        assertTuplesEqual(actual: (false, 1), expected: array.insert(now))
        assertTuplesEqual(actual: (false, 2), expected: array.insert(nowPlusOneSec))
        XCTAssertEqual(3, array.count)
        XCTAssertEqual(now, array.remove(now))
        XCTAssertEqual(2, array.count)
    }
    
    func testRemoveAll() {
        XCTAssertTrue(array.isEmpty)
        array.removeAll()
        XCTAssertTrue(array.isEmpty)
        assertTuplesEqual(actual: (false, 0), expected: array.insert(now))
        array.removeAll()
        XCTAssertTrue(array.isEmpty)
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowMinusOneSec))
        assertTuplesEqual(actual: (false, 1), expected: array.insert(now))
        XCTAssertEqual(2, array.count)
        array.removeAll()
        XCTAssertTrue(array.isEmpty)
    }
    
    func testOrderedArrayMatchingOrPreviousToEntry() {
        let nowMinusTwoSec = now.addingTimeInterval(-2)
        let nowMinusThreeSec = now.addingTimeInterval(-3)
        let nowPlusTwoSec = now.addingTimeInterval(+2)
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowPlusTwoSec))
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowMinusTwoSec))
        assertTuplesEqual(actual: (false, 1), expected: array.insert(now))
        XCTAssertEqual(now, array[now, .previous])
        XCTAssertEqual(nowMinusTwoSec, array[nowMinusOneSec, .previous])
        XCTAssertNil(array[nowMinusThreeSec, .previous])
        XCTAssertEqual(nowMinusTwoSec, array[nowMinusTwoSec, .previous])
    }
    
    func testOrderedArrayMatchingOrLaterToEntry() {
        let nowMinusTwoSec = now.addingTimeInterval(-2)
        let nowPlusTwoSec = now.addingTimeInterval(+2)
        let nowPlusThreeSec = now.addingTimeInterval(+3)
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowPlusTwoSec))
        assertTuplesEqual(actual: (false, 0), expected: array.insert(nowMinusTwoSec))
        assertTuplesEqual(actual: (false, 1), expected: array.insert(now))
        XCTAssertEqual(now, array[now, .after])
        XCTAssertEqual(nowPlusTwoSec, array[nowPlusOneSec, .after])
        XCTAssertNil(array[nowPlusThreeSec, .after])
        XCTAssertEqual(nowPlusTwoSec, array[nowPlusTwoSec, .after])
    }
    
    static var allTests = [
        ("testCount", testCount),
        ("testOrderedArrayInsertAllowDuplicates", testOrderedArrayInsertAllowDuplicates),
        ("testOrderedArrayInsertDontAllowDuplicates", testOrderedArrayInsertDontAllowDuplicates),
        ("testIsEmpty", testIsEmpty),
        ("testRemoveAtIndex", testRemoveAtIndex),
        ("testOrderedArrayRemove", testOrderedArrayRemove),
        ("testRemoveAll", testRemoveAll),
        ("testOrderedArrayMatchingOrPreviousToEntry", testOrderedArrayMatchingOrPreviousToEntry),
        ("testOrderedArrayMatchingOrLaterToEntry", testOrderedArrayMatchingOrLaterToEntry),
        ("testOrderedArrayRemove", testOrderedArrayRemove),
    ]
}
