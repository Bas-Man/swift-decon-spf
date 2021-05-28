/// Structure definition of a Mechanism.
public struct Mechanism {
    /// [MechanismKind](/MechanismKind/)
    internal var kind: MechanismKind;
    /// [Qualifier](/Qualifier/) of the current Mechanism
    internal var qualifier: Qualifier;
    /// The value of the current Mechanism
    internal var mechanism: String?;
    
    /**
            Initialises a new Mechanism
            - Parameters:
                - k: What kind of Mechanism this represents
                - q: What Qualifier has been applied.
                - m: What is the value for this Mechanism
  
            - Returns:
                An instance of Mechanism.
     
     */
    public init(k: MechanismKind, q: Qualifier, m: String? = nil) {
        kind = k;
        qualifier = q;
        mechanism = m;
    }
    /**
     Access the attribute `mechanism`
     - returns: An empty string if the value is nil or the string stored in `mechanism`
     */
    public func mechanismString() -> String {
        self.mechanism ?? "";
    }
    /**
     Returns the String representation of the Mechanism.
        This will recreate the original string for the mechanism
        # Example:
        ```
        let Mech = Mechanism(k: Mechanism.Ip4,
                             q: Qualifier.Pass,
                             m: "192.168.11.0/24");
        Mech.asMechanism();
        ```
        This produces the output
        ```
        ip4:192.168.11.0/24
        ```
     - Returns: String
     
     */
    public func asMechanism() -> String {
        var mechanismString = String();
        mechanismString += self.qualifier.get();
        // Access the string for this mechanism's kind.
        mechanismString += self.kind.get();
        // Access the string for the mechanism
        mechanismString += self.mechanism ?? "";
        return mechanismString;
    }
    /// Access attribute kind
    /// - Returns: The value of kind.
    public func whatKind() -> MechanismKind {
        return self.kind;
    }
    public func isPass() -> Bool {
        if self.qualifier == Qualifier.Pass || self.qualifier == Qualifier.None {
            return true
        }
        return false
    }
    public func isFail() -> Bool {
        return self.qualifier == Qualifier.Fail;
    }
    public func isSoftFail() -> Bool {
        return self.qualifier == Qualifier.SoftFail;
    }
    public func isNeutral() -> Bool {
        return self.qualifier == Qualifier.Neutral;
    }
    public func isNone() -> Bool {
        return self.qualifier == Qualifier.None;
    }
}

