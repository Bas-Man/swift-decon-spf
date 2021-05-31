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

