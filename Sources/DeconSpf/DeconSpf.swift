enum Qualifier: String {
    case Pass
    case Fail
    case SoftFail
    case Neutral
    case None
    
    func get() -> String {
        switch self {
        case .Pass:
            return "+"
        case .Fail:
            return "-"
        case .SoftFail:
            return "~"
        case .Neutral:
            return "?"
        case .None:
            return ""
        }
    }
}
enum MechanismKind {
    case Redirect, Include, A, MX, ip4, ip6, All;
    
    func get() -> String {
        switch self {
        case .Redirect:
            return "redirect="
        case .Include:
            return "include:"
        case .A:
            return "a"
        case .MX:
            return "mx"
        case .ip4:
            return "ip4:"
        case .ip6:
            return "ip6:"
        case .All:
            return "all"
        }
    }
}

struct Mechanism {
    var kind: MechanismKind;
    var qualifier: Qualifier;
    var mechanism: String;
    
    init(k: MechanismKind, q: Qualifier, m: String) {
        kind = k;
        qualifier = q;
        mechanism = m;
    }
    func mechanismString() -> String {
        self.mechanism;
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
