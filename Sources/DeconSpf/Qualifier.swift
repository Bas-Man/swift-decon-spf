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

