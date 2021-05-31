// Copyright 2021 Adam Spann
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this
// package.

/**
List of the kinds of Mechanisms that are supported.
 
The *raw values* of each case are also used when asMechanism() is called.
 
*/
@frozen
public enum MechanismKind: String {
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
