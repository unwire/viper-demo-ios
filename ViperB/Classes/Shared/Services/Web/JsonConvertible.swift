//
//  JsonConvertible.swift
//  NetsWhitelabelWalletApp
//
//  Created by Steffen Damtoft Sommer on 02/09/16.
//  Copyright © 2016 Unwire. All rights reserved.
//

import Foundation

enum JsonError: Error {
    case parsingFailed(_: String)
}
/// Represents a JSON dictionary.
typealias Json = [String: Any]


/// Extends Json dictionary to offer getting value of interred type.
extension Sequence where Iterator.Element == (key: String, value: Any) {

    /// Function for getting JSON non-optional value with inferred type for specified key.
    ///
    /// - Parameter key: A key to get value for.
    /// - Returns: Non-optional value for specified key, with type inferred.
    /// - Throws: An exception, if value of proper type can not be determined or found.
    func jsonValue<T>(_ key: String) throws -> T {
        guard let dictionary = self as? [String: Any] else {
            throw JsonError.parsingFailed("Wrong dictionary type: \(self)")
        }
        guard let value = dictionary[key] as? T else {
            let typeString = String(describing: T.self)
            let valueString = String(describing: dictionary[key])
            throw JsonError.parsingFailed("type: \(typeString), value: \(valueString)")
        }
        return value
    }

    /// Function for getting JSON optional value with inferred type for specified key.
    ///
    /// - Parameter key: A key to get value for.
    /// - Returns: Optional value for specified key, with type inferred.
    /// - Throws: An exception, if value of proper type can not be determined or found.
    func jsonOptionalValue<T>(_ key: String) throws -> T? {
        guard let dictionary = self as? [String: Any] else {
            throw JsonError.parsingFailed("Wrong dictionary type: \(self)")
        }
        let value = dictionary[key]
        if value == nil || value is NSNull {
            return nil
        }
        guard let typedValue: T? = value as? T? else {
            let tString = String(describing: T.self)
            let vString = String(describing: value)
            let vtString = String(describing: type(of: value))
            throw JsonError.parsingFailed("tString: \(tString), vString: \(vString), vtString: \(vtString)")
        }
        return typedValue
    }
}


extension Dictionary where Key:CustomStringConvertible, Value: Any {
    mutating func addElement(key: Key, value: Value?) throws {
        guard let value = value else {
            throw JsonError.parsingFailed("No value")
        }
        self[key] = value
    }

    mutating func addOptionalElement(key: Key, value: Value?) throws {
        guard let value = value else {
            return
        }
        self[key] = value
    }
}


/// Defines type to be able to be initialized from the Json dictionary.
protocol JsonDeserializable {
    init(json: Json) throws
}

/// Defines type to be able to be serialized from an entity.
protocol JsonSerializable {
    func convertToJson() throws -> Json
}
