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

final class SPFV2Tests: XCTestCase {

    func testSPFInitV2() {
        var spf = SPF(source: "spf2.0/pra a mx ~all")
        XCTAssertEqual(spf.getSource(), "spf2.0/pra a mx ~all")
        XCTAssertEqual(spf.isRedirect(), false)
        spf.parse()
        XCTAssertEqual(spf.version, "spf2.0/pra")
        XCTAssertEqual(spf.isV2(), true)
        XCTAssertEqual(spf.isValid(), true)
        // Not V1 is V2
        XCTAssertNotEqual(spf.isV1(), true)
    }
    static var allTests = [
        ("testSPFInitV2", testSPFInitV2),

    ]
}
