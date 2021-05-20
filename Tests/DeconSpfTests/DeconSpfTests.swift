import XCTest
@testable import DeconSpf;

final class SPFTests: XCTestCase {

    func testSPFInitV1() {
        var spf = SPF(source: "v=spf1 a mx ~all")
        XCTAssertEqual(spf.getSource(), "v=spf1 a mx ~all")
        XCTAssertEqual(spf.isRedirect(), false)
        spf.parse()
        XCTAssertEqual(spf.version, "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        // Not V2 is V1
        XCTAssertNotEqual(spf.isV2(), true)
        XCTAssertEqual(spf.all?.asMechanism(), "~all")
    }
    func testSPF1ParseA() {
        var spf = SPF(source: "v=spf1 a mx ~all")
        XCTAssertEqual(spf.getSource(), "v=spf1 a mx ~all")
        XCTAssertEqual(spf.isRedirect(), false)
        spf.parse()
        XCTAssertEqual(spf.version, "v=spf1")
        XCTAssertEqual(spf.isV1(), true)
        // Not V2 is V1
        XCTAssertNotEqual(spf.isV2(), true)
        XCTAssertEqual(spf.a?.asMechanism(), "a")
    }
    func testSPFParseAwithQualifier() {
        var spf = SPF(source: "v=spf1 +a all")
        spf.parse()
        XCTAssertEqual(spf.a?.asMechanism(), "+a")
    }

    func testSPFParseAwithQualifierValue() {
        var spf = SPF(source: "v=spf1 +a:example.com all")
        spf.parse()
        XCTAssertEqual(spf.a?.mechanismString(), ":example.com")
        XCTAssertEqual(spf.a?.asMechanism(), "+a:example.com")
    }

    func testSPFParseMX() {
        var spf = SPF(source: "v=spf1 a mx all")
        spf.parse()
        XCTAssertEqual(spf.mx?.asMechanism(), "mx")
    }

    func testSPFParseMXValue() {
        var spf = SPF(source: "v=spf1 a mx:test.com all")
        spf.parse()
        XCTAssertEqual(spf.mx?.asMechanism(), "mx:test.com")
    }

    func testSPFParseMXwithQualifier() {
        var spf = SPF(source: "v=spf1 a +mx all")
        spf.parse()
        XCTAssertEqual(spf.mx?.asMechanism(), "+mx")
    }
    func testSPF1ParseRedirect() {
        var spf = SPF(source: "v=spf1 redirect=_spf.example.com")
         spf.parse()
        XCTAssertEqual(spf.isRedirect(), true)
        XCTAssertEqual(spf.redirect?.asMechanism(), "redirect=_spf.example.com")
    }

    func testSPF1ParseInclude() {
        var spf = SPF(source: "v=spf1 include:_spf.example.com")
         spf.parse()
        XCTAssertEqual(spf.include?.asMechanism(), "include:_spf.example.com")
    }

    func testSPF1ParseIp4() {
        var spf = SPF(source: "v=spf1 +ip4:10.10.1.0/24 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip4?.asMechanism(), "+ip4:10.10.1.0/24")
    }
    func testSPF1ParseIp6() {
        var spf = SPF(source: "v=spf1 +ip6:1::1:1/16 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip6?.asMechanism(), "+ip6:1::1:1/16")
    }

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
        ("testSPFInitV1", testSPFInitV1),
        ("testSPF1ParseA", testSPF1ParseA),
        ("testSPFParseAwithQualifier", testSPFParseAwithQualifier),
        ("testSPFParseAwithQualifierValue", testSPFParseAwithQualifierValue),
        ("testSPF1ParseRedirect", testSPF1ParseRedirect),
        ("testSPF1ParseInclude", testSPF1ParseInclude),
        ("testSPF1ParseIp4", testSPF1ParseIp4),
        ("testSPF1ParseIp6", testSPF1ParseIp6),
        ("testSPFInitV2", testSPFInitV2),

    ]
}

