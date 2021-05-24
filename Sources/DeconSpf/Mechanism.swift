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

