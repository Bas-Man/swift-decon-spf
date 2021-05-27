/// Qualifiers that can be applied to a Mechanism
enum Qualifier: String {
    case Pass = "+";
    case Fail = "-";
    case SoftFail = "~";
    case Neutral = "?";
    case None = "";
    
    /**
     Acess the rawValue of Qualifier
     - returns: A string value for the Qualifier
     */
    func get() -> String {
        return self.rawValue;
    }
}

