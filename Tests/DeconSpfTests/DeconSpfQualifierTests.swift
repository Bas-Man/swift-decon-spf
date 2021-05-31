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

final class SPFQualifierTests: XCTestCase {

    func testQualifierPass() {
        let Q = Qualifier.Pass;
        XCTAssertEqual(Q.get(), "");
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
