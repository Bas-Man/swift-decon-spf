// Copyright 2021 Adam Spann
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this
// package.

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
        let Mech = Mechanism(k: MechanismKind.Ip4, q: Qualifier.None, m: "192.168.1.0/24");
        XCTAssertEqual(Mech.asMechanism(), "ip4:192.168.1.0/24");
        // Qualifier.Pass and Qualifier.None should both return true for isPass()
        XCTAssertEqual(Mech.isPass(), true)
    }
    func testAsMechanismIp4Pass() {
        let Mech = Mechanism(k: MechanismKind.Ip4, q: Qualifier.Pass, m: "192.168.1.0/24");
        XCTAssertEqual(Mech.asMechanism(), "ip4:192.168.1.0/24");
    }

    func testAsMechanismIp6() {
        let Mech = Mechanism(k: MechanismKind.Ip6, q: Qualifier.None, m: "X:X:X:X/16");
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
        let Mech = Mechanism(k: MechanismKind.A, q: Qualifier.None);
        XCTAssertEqual(Mech.asMechanism(), "a");
    }
    func testAsMechanismAColon() {
        let Mech = Mechanism(k: MechanismKind.A, q: Qualifier.SoftFail, m: ":mailers.example.com");
        XCTAssertEqual(Mech.asMechanism(), "~a:mailers.example.com");
    }
    func testAsMechanismMx() {
        let Mech = Mechanism(k: MechanismKind.MX, q: Qualifier.None);
        XCTAssertEqual(Mech.asMechanism(), "mx");
    }
    func testAsMechanismMxColon() {
        let Mech = Mechanism(k: MechanismKind.MX, q: Qualifier.Neutral, m: ":example.com");
        XCTAssertEqual(Mech.asMechanism(), "?mx:example.com");
    }
    func testAsMechanismAllPass() {
        let Mech = Mechanism(k: MechanismKind.All, q: Qualifier.Pass);
        XCTAssertEqual(Mech.asMechanism(), "all");
    }
    func testAsMechanismAllFail() {
        let Mech = Mechanism(k: MechanismKind.All, q: Qualifier.Fail);
        XCTAssertEqual(Mech.asMechanism(), "-all");
    }
    func testAsMechanismAllSoftFail() {
        let Mech = Mechanism(k: MechanismKind.All, q: Qualifier.SoftFail);
        XCTAssertEqual(Mech.asMechanism(), "~all");
    }
    func testAsMechanismAllNeutral() {
        let Mech = Mechanism(k: MechanismKind.All, q: Qualifier.Neutral);
        XCTAssertEqual(Mech.asMechanism(), "?all");
    }
    static var allTests = [
        ("testMechanismRedirect", testMechanismRedirect),
        ("testMechanismInclude", testMechanismInclude),
        ("testAsMechanismIp4", testAsMechanismIp4),
        ("testAsMechanismIp4Pass", testAsMechanismIp4Pass),
        ("testAsMechanismIp6", testAsMechanismIp6),
        ("testAsMechanismRedirect", testAsMechanismRedirect),
        ("testAsMechanismInclude", testAsMechanismInclude),
        ("testAsMechanismA", testAsMechanismA),
        ("testAsMechanismAColon", testAsMechanismAColon),
        ("testAsMechanismMx", testAsMechanismMx),
        ("testAsMechanismMxColon", testAsMechanismMxColon),
        ("testAsMechanismAllPass", testAsMechanismAllPass),
        ("testAsMechanismAllFail", testAsMechanismAllFail),
        ("testAsMechanismAllSoftFail", testAsMechanismAllSoftFail),
        ("testAsMechanismAllNeutral", testAsMechanismAllNeutral),
    ]
}

