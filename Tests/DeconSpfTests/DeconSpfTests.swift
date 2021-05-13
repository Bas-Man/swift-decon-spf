import XCTest
@testable import DeconSpf;

final class SPFTests: XCTestCase {

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
    static var allTests = [
        ("testMechanismRedirect", testMechanismRedirect),
        ("testMechanismInclude", testMechanismInclude),
    ]
}

