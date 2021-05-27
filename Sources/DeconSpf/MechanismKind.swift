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
    
    /**
     Acess the rawValue of MechanismKind
     - returns: A string value for the MechanismKind
     */
    func get() -> String {
        return self.rawValue;
    }
}
