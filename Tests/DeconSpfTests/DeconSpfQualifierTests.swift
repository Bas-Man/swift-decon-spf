import XCTest
@testable import DeconSpf;

final class SPFQualifierTests: XCTestCase {

    func testQualifierPass() {
        let Q = Qualifier.Pass;
        XCTAssertEqual(Q.get(), "+");
    }
    func testQualifierFail() {
        let Q = Qualifier.Fail;
        XCTAssertEqual(Q.get(), "-");
    }
    func testQualifierSoftFail() {
        let Q = Qualifier.SoftFail;
        XCTAssertEqual(Q.get(), "~");
    }
    func testQualifierNeutral() {
        let Q = Qualifier.Neutral;
        XCTAssertEqual(Q.get(), "?");
    }
    func testQualifierNone() {
        let Q = Qualifier.None;
        XCTAssertEqual(Q.get(), "");
    }

    static var allTests = [
        ("testQualifierPass", testQualifierPass),
        ("testQualifierFail", testQualifierFail),
        ("testQualifierSoftFail", testQualifierSoftFail),
        ("testQualifierNeutral", testQualifierNeutral),
        ("testQualifierNone", testQualifierNone),

    ]
}
