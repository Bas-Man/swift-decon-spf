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
        XCTAssertEqual(spf.isValid(), true)
        // Not V2 is V1
        XCTAssertNotEqual(spf.isV2(), true)
        XCTAssertEqual(spf.all?.asMechanism(), "~all")
        XCTAssert(spf.redirect == nil)
        XCTAssert(spf.include == nil)
        XCTAssert(spf.ip4 == nil)
        XCTAssert(spf.ip6 == nil)
    }
    func testSPF1IncludesOk () {
        var spf = SPF(source: "v=spf1 include:ab include:cd include:ef include:gh include:ij include:kl include:mn include:op include:qr include:st -all")
        spf.parse()
        XCTAssertEqual(spf.include?.count, 10)
        XCTAssertEqual(spf.isValid(), true)

    }
    func testSPF1TooManyIncludes() {
        var spf = SPF(source: "v=spf1 include:ab include:cd include:ef include:gh include:ij include:kl include:mn include:op include:qr include:st include:uv -all")
        spf.parse()
        XCTAssertEqual(spf.include?.count, 11)

        XCTAssertEqual(spf.isValid(), false)
    }
    func testSPF1TooLong() { // Exceeds Max length of 255 characters
        var spf = SPF(source: "v=spf1 include:_spf.ab.example.com include:spf_.cd.example.com include:_spf.ef.example.com include:gh.example.com include:ij.example.com include:kl.example.com include:mn.example.com include:op.example.com include:qr.example.com include:st.example.com -all")
        spf.parse()
        XCTAssertEqual(spf.source.count, 256) // Exceeds max length of 255 characters
        XCTAssertEqual(spf.isValid(), false)
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
        XCTAssertEqual(spf.a?[0].asMechanism(), "a")
        XCTAssertEqual(spf.all?.asMechanism(), "all")

    }

    func testSPFParseAwithQualifierValue() {
        var spf = SPF(source: "v=spf1 +a:example.com all")
        spf.parse()
        XCTAssertEqual(spf.a?[0].mechanismString(), ":example.com")
        XCTAssertEqual(spf.a?[0].asMechanism(), "a:example.com")
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
        XCTAssertEqual(spf.mx?[0].asMechanism(), "mx")
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
        XCTAssertEqual(spf.ip4?[0].asMechanism(), "ip4:10.10.1.0/24")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }
    func testSPF1ParseIp4x2() {
        var spf = SPF(source: "v=spf1 +ip4:10.10.1.0/24 +ip4:192.168.11.0/16 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip4?[0].asMechanism(), "ip4:10.10.1.0/24")
        XCTAssertEqual(spf.ip4?[1].asMechanism(), "ip4:192.168.11.0/16")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }
    func testSPF1ParseIp6() {
        var spf = SPF(source: "v=spf1 +ip6:1::1:1/16 mx ~all")
         spf.parse()
        XCTAssertEqual(spf.ip6?[0].asMechanism(), "ip6:1::1:1/16")
        XCTAssertEqual(spf.all?.asMechanism(), "~all")

    }

    func testSPF1AsSpf() {
        var spf = SPF(source: "v=spf1 a mx all")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }
    func testSPF1AsSpfMX() {
        var spf = SPF(source: "v=spf1 mx:test.com -mx:example.com ?all")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }
    func testSPF1AsSpfInclude() {
        var spf = SPF(source: "v=spf1 include:_spf.test.com include:_spf2.test.com ?all")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }
    func testSPF1AsSpfIp4() {
        var spf = SPF(source: "v=spf1 ip4:203.32.160.0/24 ip4:203.32.166.0/24 ?all")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }
    func testSPF1AsSpfIp6() {
        var spf = SPF(source: "v=spf1 ip6:2001:4860:4000::/36 ip6:2404:6800:4000::/36 ?all")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }
    func testSPF1AsSpfIp4Ip6() {
        var spf = SPF(source: "v=spf1 ip4:203.32.160.0/24 ip4:203.32.166.0/24 ip6:2001:4860:4000::/36 ip6:2404:6800:4000::/36 ?all")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }

    func testSPF1asSpfRedirect() {
        var spf = SPF(source: "v=spf1 redirect=_spf.example.com")
        spf.parse()
        XCTAssertEqual(spf.asSpf(), spf.getSource())
    }
    func testSPFBlank() {
        let spf = SPF()
        XCTAssertEqual(spf.getSource(), "")
        XCTAssertEqual(spf.isValid(), false)
    }
    static var allTests = [
        ("testSPFInitV1", testSPFInitV1),
        ("testSPF1IncludesOk", testSPF1IncludesOk),
        ("testSPF1TooManyIncludes", testSPF1TooManyIncludes),
        ("testSPF1TooLong", testSPF1TooLong),
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

