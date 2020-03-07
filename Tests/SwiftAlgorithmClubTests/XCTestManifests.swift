import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(swift_algorithm_clubTests.allTests),
    ]
}
#endif
