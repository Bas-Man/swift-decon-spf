import XCTest
@testable import DeconSpf;

final class SPFMechanismKindTests: XCTestCase {

    func testMechanismKindRedirect() {
        let MK = MechanismKind.Redirect;
        XCTAssertEqual(MK.get(), "redirect=");
    }
    func testMechanismKindInclude() {
        let MK = MechanismKind.Include;
        XCTAssertEqual(MK.get(), "include:");
    }
    func testMechanismKindA() {
        let MK = MechanismKind.A;
        XCTAssertEqual(MK.get(), "a");
    }
    func testMechanismKindMX() {
        let MK = MechanismKind.MX;
        XCTAssertEqual(MK.get(), "mx");
    }
    func testMechanismKindIp4() {
        let MK = MechanismKind.Ip4;
        XCTAssertEqual(MK.get(), "ip4:");
    }
    func testMechanismKindIp6() {
        let MK = MechanismKind.Ip6;
        XCTAssertEqual(MK.get(), "ip6:");
    }
    func testMechanismKindAll() {
        let MK = MechanismKind.All;
        XCTAssertEqual(MK.get(), "all");
    }

    static var allTests = [
        ("testMechanismKindRedirect", testMechanismKindRedirect),
        ("testMechanismKindInclude", testMechanismKindInclude),
        ("testMechanismKindA", testMechanismKindA),
        ("testMechanismKindMX", testMechanismKindMX),
        ("testMechanismKindIp4", testMechanismKindIp4),
        ("testMechanismKindIp6", testMechanismKindIp6),
        ("testMechanismKindAll", testMechanismKindAll),

    ]
}

