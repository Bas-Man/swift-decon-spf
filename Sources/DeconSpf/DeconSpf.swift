import Foundation

/// Qualifiers that can be applied to a Mechanism
enum Qualifier: String {
    case Pass = "+";
    case Fail = "-";
    case SoftFail = "~";
    case Neutral = "?";
    case None = "";
    
    func get() -> String {
        return self.rawValue;
    }
}
/**
List of the kinds of Mechanisms that are supported.
 
The *raw values* of each case are also used when asMechanism() is called.
 
*/
 enum MechanismKind: String {
    case Redirect = "redirect=";
    case Include = "include:"
    case A = "a";
    case MX = "mx";
    case Ip4 = "ip4:";
    case Ip6 = "ip6:"
    case All = "all";
    
    func get() -> String {
        return self.rawValue;
    }
}
/// Structure definition of a Mechanism.
struct Mechanism {
    /// MechanismKind
    var kind: MechanismKind;
    /// Qualifier of the current Mechanism
    var qualifier: Qualifier;
    /// The value of the current Mechanism
    var mechanism: String?;
    
    /**
            Initialises a new Mechanism
            - Parameters:
                - k: What kind of Mechanism this represents
                - q: What Qualifier has been applied.
                - m: What is the value for this Mechanism
  
            - Returns:
                A Mechanism instance.
     
     */
    init(k: MechanismKind, q: Qualifier, m: String? = nil) {
        kind = k;
        qualifier = q;
        mechanism = m;
    }
    func mechanismString() -> String {
        self.mechanism ?? "";
    }
    /**
     Returns the String representation of the Mechanism.
        This will recreate the original string for the mechanism
        # Example:
        ```
        let Mech = Mechanism(k: Mechanism.Ip4, q: Qualifier.Pass, m: "192.168.11.0/24");
        Mech.asMechanism();
        ```
        This produces the output
        ```
        ip4:192.168.11.0/24
        ```
     - Returns:
     String
     
     */
    func asMechanism() -> String {
        var mechanismString = String();
        mechanismString += self.qualifier.get();
        // Access the string for this mechanism's kind.
        mechanismString += self.kind.get();
        // Access the string for the mechanism
        mechanismString += self.mechanism ?? "";
        return mechanismString;
    }
    func whatKind() -> MechanismKind {
        return self.kind;
    }
    func isPass() -> Bool {
        return self.qualifier == Qualifier.Pass;
    }
    func isFail() -> Bool {
        return self.qualifier == Qualifier.Fail;
    }
    func isSoftFail() -> Bool {
        return self.qualifier == Qualifier.SoftFail;
    }
    func isNeutral() -> Bool {
        return self.qualifier == Qualifier.Neutral;
    }
    func isNone() -> Bool {
        return self.qualifier == Qualifier.None;
    }
}

struct SPF {
    private(set) var source: String
    var version: String = ""
    var redirect: Mechanism?
    var is_redirect: Bool = false
    var include: Mechanism?
    var a: Mechanism?
    var mx: Mechanism?
    var ip4: Mechanism?
    var ip6: Mechanism?
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
        if self.version.starts(with: "v=") {
            return true
        }
        return false
    }
    func isV2() -> Bool {
        if self.version.starts(with: "spf2") {
            return true
        }
        return false
    }
    mutating func parse() {
        let aRegex = #"^([+?~-])?a([:/]{0,1}.*)?"#
        let MxRegex = #"^([+?~-])?mx([:/]{0,1}.*)?"#
        let splitString = self.source.split(separator: " ")
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
                self.include = Mechanism(k: MechanismKind.Include,
                                         q: identifyQualifier(prefix: qualifierMechanism[0]),
                                         m: String(qualifierMechanism[1]))
            }
            // Done
            else if (subString.range(of: "ip4:") != nil) {
                self.ip4 = processIp(subString: subString, kind: MechanismKind.Ip4)
            }
            // Done
            else if (subString.range(of: "ip6:") != nil) {
                self.ip6 = processIp(subString: subString, kind: MechanismKind.Ip6)
            }
            // Checking that the string ends with "all"
            else if (subString.hasSuffix("all")) {
                self.all = Mechanism(k: MechanismKind.All,
                                     q: identifyQualifier(prefix: subString))
            }
            // A and Mx cases are complex.
            else if (!subString.hasSuffix("all")) {
                let aMechanism = String(subString).matchMechanism(regex: aRegex,
                                                             kind: MechanismKind.A)
                if aMechanism != nil {
                    self.a = aMechanism
                    continue
                }
            }
            let mxMechanism = String(subString).matchMechanism(regex: MxRegex, kind: MechanismKind.MX)
            if mxMechanism != nil {
                self.mx = mxMechanism
                continue
            }
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
    func matchMechanism(regex: String, kind: MechanismKind) -> Mechanism? {
        
        let capturePattern = regex
        var elements: [String] = []
        
        let nameRange = NSRange(
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
            if matchRange == nameRange { continue }
            
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
