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

struct Mechanism {
    var kind: MechanismKind;
    var qualifier: Qualifier;
    var mechanism: String?;
    
    init(k: MechanismKind, q: Qualifier, m: String? = nil) {
        kind = k;
        qualifier = q;
        mechanism = m;
    }
    func mechanismString() -> String {
        self.mechanism ?? "";
    }
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
