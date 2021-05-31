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

