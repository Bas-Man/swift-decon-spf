/// Qualifiers that can be applied to a Mechanism
@frozen
public enum Qualifier: String {
    case Pass = "";
    case Fail = "-";
    case SoftFail = "~";
    case Neutral = "?";
    case None;
    
    /**
     Acess the rawValue of Qualifier
     - returns: A string value for the Qualifier
     */
    public func get() -> String {
        // None and Pass are equal
        if self == Qualifier.None {
            return Qualifier.Pass.rawValue
        }
        return self.rawValue;
    }
}

