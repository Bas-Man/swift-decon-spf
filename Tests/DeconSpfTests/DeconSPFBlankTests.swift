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

final class SPFBlankTests: XCTestCase {

    func testSPFBlank() {
        let spf = SPF()
        XCTAssertEqual(spf.getSource(), "")
        XCTAssertEqual(spf.isValid(), false)
        XCTAssertEqual(spf.fromSource, false)
    }
    func testSPFAddVersion() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
    }
    func testSPF1AddRedirect() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addRedirect(fromStr: "_spf.example.com")
        XCTAssertEqual(spf.asSpf(), "v=spf1 redirect=_spf.example.com")
    }
    func testSPF1AddRedirectAddAll() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addRedirect(fromStr: "_spf.example.com")
        spf.addAll(q: Qualifier.Pass)
        XCTAssertEqual(spf.asSpf(), "v=spf1 redirect=_spf.example.com all")
    }
    func testSPF1AddRedirectAddAll2() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addRedirect(fromStr: "_spf.example.com")
        let all = Mechanism(k: MechanismKind.All, q: Qualifier.Pass)
        spf.addAll(mechanism: all)
        XCTAssertEqual(spf.asSpf(), "v=spf1 redirect=_spf.example.com all")
    }
    func testSPF1AddAPass() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addA(q: Qualifier.Pass)
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 a all")
    }
    func testSPF1AddASoftFail() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addA(q: Qualifier.SoftFail)
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 ~a all")
    }
    func testSPF1AddAPassColon() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addA(q: Qualifier.Pass, fromStr: ":mail.example.com")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 a:mail.example.com all")
    }
    func testSPF1AddASlash() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addA(q: Qualifier.SoftFail, fromStr: "/24")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 ~a/24 all")
    }

    func testSPF1AddAFromMechanism() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addA(mechanism: Mechanism(k: MechanismKind.A, q: Qualifier.Pass))
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 a all")
    }
    func testSPF1AddMX() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addMx(q: Qualifier.Pass)
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 mx all")
    }
    func testSPF1AddMXColon() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addMx(q: Qualifier.Pass, fromStr: ":example.com")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 mx:example.com all")
    }
    func testSPF1AddMXSlash() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addMx(q: Qualifier.Pass, fromStr: "/24")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 mx/24 all")
    }

    func testSPF1AddMXFromMechanism() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addMx(mechanism: Mechanism(k: MechanismKind.MX, q: Qualifier.Pass))
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 mx all")
    }
    func testSPF1AddIncludeFromStr() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addInclude(q: Qualifier.Pass,
                       fromStr: "_spf2.example.com")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 include:_spf2.example.com all")
    }

    func testSPF1AddIncludeFromMechanism() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addInclude(mechanism: Mechanism(k: MechanismKind.Include,
                                       q: Qualifier.Pass,
                                       m: "_spf2.example.com"))
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 include:_spf2.example.com all")
    }
    func testSPF1AddIp4FromStr() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addIp4(q: Qualifier.Pass, fromStr: "203.32.160.0/24")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 ip4:203.32.160.0/24 all")
    }
    func testSPF1AddIp4FromMechanism() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addIp4(mechanism: Mechanism(k: MechanismKind.Ip4,
                                       q: Qualifier.Pass,
                                       m: "203.32.160.0/24"))
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 ip4:203.32.160.0/24 all")
    }
    func testSPF1AddIp6FromStr() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addIp6(q: Qualifier.Pass, fromStr: "2404:6800:4000::/36")
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 ip6:2404:6800:4000::/36 all")
    }
    func testSPF1AddIp6FromMechanism() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        spf.addIp6(mechanism: Mechanism(k: MechanismKind.Ip6,
                                       q: Qualifier.Pass,
                                       m: "2404:6800:4000::/36"))
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.asSpf(), "v=spf1 ip6:2404:6800:4000::/36 all")
    }
    func testSPF1validate() {
        var spf = SPF()
        spf.addVersion(version: "v=spf1")
        spf.addIp6(mechanism: Mechanism(k: MechanismKind.Ip6,
                                       q: Qualifier.Pass,
                                       m: "2404:6800:4000::/36"))
        spf.addAll(mechanism: Mechanism(k: MechanismKind.All, q: Qualifier.Pass))
        XCTAssertEqual(spf.isV1(), true)
        XCTAssertEqual(spf.asSpf(), "v=spf1 ip6:2404:6800:4000::/36 all")
        XCTAssertEqual(spf.isV1(), true)
        XCTAssertEqual(spf.validate(), true)
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }

    static var allTests = [
        ("testSPFBlank", testSPFBlank),
    ]
}

