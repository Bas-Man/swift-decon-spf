import XCTest
@testable import DeconSpf;

final class SPFMechanismTests: XCTestCase {

    func testMechanismRedirect() {
        let Mech = Mechanism(k: MechanismKind.Redirect, q: Qualifier.None, m: "test.com");
        XCTAssertEqual(Mech.mechanismString(), "test.com");
        XCTAssertEqual(Mech.whatKind(), MechanismKind.Redirect);
        XCTAssertNotEqual(Mech.whatKind(), MechanismKind.A);
        XCTAssertEqual(Mech.isNone(), true);
    }
    func testMechanismInclude() {
        let Mech = Mechanism(k: MechanismKind.Include, q: Qualifier.Pass, m: "_spf.test.com");
        XCTAssertEqual(Mech.mechanismString(), "_spf.test.com");
        XCTAssertEqual(Mech.whatKind(), MechanismKind.Include);
        XCTAssertNotEqual(Mech.whatKind(), MechanismKind.Redirect);
        XCTAssertNotEqual(Mech.whatKind(), MechanismKind.A);
        XCTAssertEqual(Mech.isPass(), true);
    }
    func testAsMechanismIp4() {
        let Mech = Mechanism(k: MechanismKind.ip4, q: Qualifier.None, m: "192.168.1.0/24");
        XCTAssertEqual(Mech.asMechanism(), "ip4:192.168.1.0/24");
    }
    func testAsMechanismIp6() {
        let Mech = Mechanism(k: MechanismKind.ip6, q: Qualifier.None, m: "X:X:X:X/16");
        XCTAssertEqual(Mech.asMechanism(), "ip6:X:X:X:X/16");
    }
    func testAsMechanismRedirect() {
        let Mech = Mechanism(k: MechanismKind.Redirect, q: Qualifier.None, m: "_spf.example.com");
        XCTAssertEqual(Mech.asMechanism(), "redirect=_spf.example.com");
    }
    func testAsMechanismInclude() {
        let Mech = Mechanism(k: MechanismKind.Include, q: Qualifier.None, m: "_spf1.example.com");
        XCTAssertEqual(Mech.asMechanism(), "include:_spf1.example.com");
    }
    func testAsMechanismA() {
        let Mech = Mechanism(k: MechanismKind.A, q: Qualifier.None, m: "");
        XCTAssertEqual(Mech.asMechanism(), "a");
    }
    func testAsMechanismMx() {
        let Mech = Mechanism(k: MechanismKind.MX, q: Qualifier.None, m: "");
        XCTAssertEqual(Mech.asMechanism(), "mx");
    }

    static var allTests = [
        ("testMechanismRedirect", testMechanismRedirect),
        ("testMechanismInclude", testMechanismInclude),
        ("testAsMechanismIp4", testAsMechanismIp4),
        ("testAsMechanismIp6", testAsMechanismIp6),
        ("testAsMechanismRedirect", testAsMechanismRedirect),
        ("testAsMechanismInclude", testAsMechanismInclude),
        ("testAsMechanismA", testAsMechanismA),
        ("testAsMechanismMx", testAsMechanismMx),
    ]
}

