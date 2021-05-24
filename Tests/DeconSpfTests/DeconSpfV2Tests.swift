import XCTest
@testable import DeconSpf;

final class SPFV2Tests: XCTestCase {

    func testSPFInitV2() {
        var spf = SPF(source: "spf2.0/pra a mx ~all")
        XCTAssertEqual(spf.getSource(), "spf2.0/pra a mx ~all")
        XCTAssertEqual(spf.isRedirect(), false)
        spf.parse()
        XCTAssertEqual(spf.version, "spf2.0/pra")
        XCTAssertEqual(spf.isV2(), true)
        // Not V1 is V2
        XCTAssertNotEqual(spf.isV1(), true)
    }
    static var allTests = [
        ("testSPFInitV2", testSPFInitV2),

    ]
}
