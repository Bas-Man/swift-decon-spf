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
        XCTAssert(spf.redirect == nil)
        XCTAssert(spf.include == nil)
        XCTAssert(spf.ip4 == nil)
        XCTAssert(spf.ip6 == nil)
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
        XCTAssertEqual(spf.a?[0].asMechanism(), "a")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }
    func testSPFParseAwithQualifier() {
        var spf = SPF(source: "v=spf1 +a all")
        spf.parse()
        XCTAssertEqual(spf.a?[0].asMechanism(), "+a")
        XCTAssertEqual(spf.all?.asMechanism(), "all")

    }

    func testSPFParseAwithQualifierValue() {
        var spf = SPF(source: "v=spf1 +a:example.com all")
        spf.parse()
        XCTAssertEqual(spf.a?[0].mechanismString(), ":example.com")
        XCTAssertEqual(spf.a?[0].asMechanism(), "+a:example.com")
        XCTAssertEqual(spf.all?.asMechanism(), "all")
    }

    func testSPFParseMX() {
        var spf = SPF(source: "v=spf1 a mx all")
        spf.parse()
        XCTAssertEqual(spf.mx?[0].asMechanism(), "mx")
    }

    func testSPFParseMXValue() {
        var spf = SPF(source: "v=spf1 a mx:test.com all")
        spf.parse()
        XCTAssertEqual(spf.mx?[0].asMechanism(), "mx:test.com")
    }

    func testSPFParseMXwithQualifier() {
        var spf = SPF(source: "v=spf1 a +mx all")
        spf.parse()
        XCTAssertEqual(spf.mx?[0].asMechanism(), "+mx")
       XCTAssertEqual(spf.all?.asMechanism(), "all")

    }
    func testSPF1ParseRedirect() {
        var spf = SPF(source: "v=spf1 redirect=_spf.example.com")
         spf.parse()
        XCTAssertEqual(spf.isRedirect(), true)
        XCTAssertEqual(spf.redirect?.asMechanism(), "redirect=_spf.example.com")
        XCTAssert(spf.a == nil)
        XCTAssert(spf.include == nil)
        XCTAssert(spf.ip4 == nil)
        XCTAssert(spf.ip6 == nil)
    }

    func testSPF1ParseInclude() {
        var spf = SPF(source: "v=spf1 include:_spf.example.com")
         spf.parse()
        XCTAssertEqual(spf.include?[0].asMechanism(), "include:_spf.example.com")
    }

    func testSPF1ParseIp4() {
        var spf = SPF(source: "v=spf1 +ip4:10.10.1.0/24 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip4?[0].asMechanism(), "+ip4:10.10.1.0/24")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }
    func testSPF1ParseIp4x2() {
        var spf = SPF(source: "v=spf1 +ip4:10.10.1.0/24 +ip4:192.168.11.0/16 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip4?[0].asMechanism(), "+ip4:10.10.1.0/24")
        XCTAssertEqual(spf.ip4?[1].asMechanism(), "+ip4:192.168.11.0/16")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }
    func testSPF1ParseIp6() {
        var spf = SPF(source: "v=spf1 +ip6:1::1:1/16 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip6?[0].asMechanism(), "+ip6:1::1:1/16")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }

    static var allTests = [
        ("testSPFInitV1", testSPFInitV1),
        ("testSPF1ParseA", testSPF1ParseA),
        ("testSPFParseAwithQualifier", testSPFParseAwithQualifier),
        ("testSPFParseAwithQualifierValue", testSPFParseAwithQualifierValue),
        ("testSPFParseMX", testSPFParseMX),
        ("testSPFParseMXValue", testSPFParseMXValue),
        ("testSPFParseMXwithQualifier", testSPFParseMXwithQualifier),
        ("testSPF1ParseRedirect", testSPF1ParseRedirect),
        ("testSPF1ParseInclude", testSPF1ParseInclude),
        ("testSPF1ParseIp4", testSPF1ParseIp4),
        ("testSPF1ParseIp4x2", testSPF1ParseIp4x2),
        ("testSPF1ParseIp6", testSPF1ParseIp6),
    ]
}

