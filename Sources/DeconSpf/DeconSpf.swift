enum Qualifier: String {
    case Pass = "+"
    case Fail = "-"
    case SoftFail = "~"
    case Neutral = "?"
    case None
}
enum MechanismKind {
    case Redirect, Include, A, MX, ip4, ip6, All;
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
