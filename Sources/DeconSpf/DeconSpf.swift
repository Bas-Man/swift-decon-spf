import Foundation

struct SPF {
    private(set) var source: String
    var version: String = ""
    var redirect: Mechanism?
    var is_redirect: Bool = false
    var include: [Mechanism]?
    var a: [Mechanism]?
    var mx: [Mechanism]?
    var ip4: [Mechanism]?
    var ip6: [Mechanism]?
    var all: Mechanism?
    
    init(source: String) {
        self.source = source
    }
    func getSource() -> String {
        self.source
    }
    func isRedirect() -> Bool {
        self.is_redirect
    }
    func isV1() -> Bool {
        self.version.starts(with: "v=")
     }
    func isV2() -> Bool {
        self.version.starts(with: "spf2")
    }
    mutating func parse() {
        let aRegex = #"^([+?~-])?a([:/]{0,1}.*)?"#
        let MxRegex = #"^([+?~-])?mx([:/]{0,1}.*)?"#
        let splitString = self.source.split(separator: " ")
        var includeData: [Mechanism] = []
        var aData: [Mechanism] = []
        var mxData: [Mechanism] = []
        var ip4Data: [Mechanism] = []
        var ip6Data: [Mechanism] = []
        for subString in splitString {
            //Done
            if (subString.starts(with: "v=") || subString.starts(with: "spf2")) {
                self.version = String(subString)
            }
            // Done
            else if (subString.range(of: "redirect=") != nil) {
                let qualifierMechanism = subString.split(separator: "=")
                self.redirect = Mechanism(k: MechanismKind.Redirect,
                                          q: identifyQualifier(prefix: qualifierMechanism[0]),
                                          m: String(qualifierMechanism[1]))
                self.is_redirect = true
            }
            // Done
            else if (subString.range(of: "include:") != nil) {
                let qualifierMechanism = subString.split(separator: ":")
                includeData.append(
                    Mechanism(k: MechanismKind.Include,
                              q: identifyQualifier(
                                    prefix: qualifierMechanism[0]),
                                    m: String(qualifierMechanism[1]
                                 )
                    )
                )
            }
            // Done
            else if (subString.range(of: "ip4:") != nil) {
                ip4Data.append(
                    processIp(subString: subString,
                              kind: MechanismKind.Ip4)
                )
            }
            // Done
            else if (subString.range(of: "ip6:") != nil) {
                ip6Data.append(
                    processIp(subString: subString,
                              kind: MechanismKind.Ip6)
                )
            }
            // Checking that the string ends with "all"
            else if (subString.hasSuffix("all")) {
                self.all = Mechanism(k: MechanismKind.All,
                                     q: identifyQualifier(prefix: subString))
            }
            // aMechanism is only appended if aMechanism is not nil
            else if let aMechanism =
                    String(subString).matchMechanism(regex: aRegex,
                                                     kind: MechanismKind.A) {
                    aData.append(aMechanism)
                }
            // mxMechanism is only appended if mxMechanism is not nil
            else if let mxMechanism =
                String(subString).matchMechanism(regex: MxRegex,
                                                 kind: MechanismKind.MX) {
                    mxData.append(mxMechanism)
                }
        }
        if !includeData.isEmpty {
            self.include = includeData
        }
        if !aData.isEmpty {
            self.a = aData
        }
        if !mxData.isEmpty {
            self.mx = mxData
        }
        if !ip4Data.isEmpty {
            self.ip4 = ip4Data
        }
        if !ip6Data.isEmpty {
            self.ip6 = ip6Data
        }
    }
}

private func identifyQualifier<S: StringProtocol>(prefix s: S)  -> Qualifier {
    let char = String(s.prefix(1))
    let c = Character(char)
    if !c.isLetter {
        switch char {
        case "+":
            return Qualifier.Pass
        case "-":
            return Qualifier.Fail
        case "~":
            return Qualifier.SoftFail
        case "?":
            return Qualifier.Neutral
        default:
            return Qualifier.None
        }
    }
    return Qualifier.None
}

private func processIp<S: StringProtocol>(subString s: S, kind: MechanismKind) -> Mechanism {
    let qualifierMechanism = s.split(separator: ":", maxSplits: 1, omittingEmptySubsequences: true)
    let qualifier = identifyQualifier(prefix: qualifierMechanism[0])
    return Mechanism(k: kind, q: qualifier, m: String(qualifierMechanism[1]))
    
}

extension String {
    // Creates a Mechanism if the the regular expression finds a match.
    // If there is no match, nil is returned
    func matchMechanism(regex: String, kind: MechanismKind) -> Mechanism? {
        
        let capturePattern = regex
        // Array to store matched substrings, used to create a new Mechanism
        var elements: [String] = []
        
        // Get the range of the string
        let stringRange = NSRange(
            self.startIndex..<self.endIndex,
            in: self
        )

        let captureRegex = try! NSRegularExpression(
            pattern: capturePattern,
            options: .caseInsensitive
        )
        let matches = captureRegex.matches(in: self, options: [], range: NSRange(location: 0, length: (self as NSString).length))

        // We didn't find a match. Return nil
        guard let match = matches.first else { return nil  }

        // For each matched range, extract the capture group
        for rangeIndex in 0..<match.numberOfRanges {
            let matchRange = match.range(at: rangeIndex)
            
            // Ignore matching the entire username string
            if matchRange == stringRange { continue }
            
            // Extract the substring matching the capture group
            if let substringRange = Range(matchRange, in: self) {
                let capture = String(self[substringRange])
                elements.append(capture)
            
            }
        }
        // If count is less than 2 there was no Qualifier
        var q = Qualifier.None
        if elements.count == 2 {
            q = identifyQualifier(prefix: elements.first!)
        }
        
        return Mechanism(k: kind, q: q, m: elements.last!)
    }
}
