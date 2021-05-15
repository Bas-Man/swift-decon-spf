import XCTest
@testable import DeconSpf;

final class SPFMechanimsKindTests: XCTestCase {

    func testMechanimsKindRedirect() {
        let MK = MechanismKind.Redirect;
        XCTAssertEqual(MK.get(), "redirect=");
    }
    func testMechanimsKindInclude() {
        let MK = MechanismKind.Include;
        XCTAssertEqual(MK.get(), "include:");
    }
    func testMechanimsKindA() {
        let MK = MechanismKind.A;
        XCTAssertEqual(MK.get(), "a");
    }
    func testMechanimsKindMX() {
        let MK = MechanismKind.MX;
        XCTAssertEqual(MK.get(), "mx");
    }
    func testMechanimsKindIp4() {
        let MK = MechanismKind.Ip4;
        XCTAssertEqual(MK.get(), "ip4:");
    }
    func testMechanimsKindIp6() {
        let MK = MechanismKind.Ip6;
        XCTAssertEqual(MK.get(), "ip6:");
    }
    func testMechanimsKindAll() {
        let MK = MechanismKind.All;
        XCTAssertEqual(MK.get(), "all");
    }

    static var allTests = [
        ("testMechanismKindRedirect", testMechanimsKindRedirect),
        ("testMechanismKindInclude", testMechanimsKindInclude),
        ("testMechanismKindA", testMechanimsKindA),
        ("testMechanismKindMX", testMechanimsKindMX),
        ("testMechanismKindIp4", testMechanimsKindIp4),
        ("testMechanismKindIp6", testMechanimsKindIp6),
        ("testMechanismKindAll", testMechanimsKindAll),

    ]
}

