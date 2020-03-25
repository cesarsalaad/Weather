//
//  JSONParsing.swift
//  Weather
//
//  Created by Cesar Tesen on 3/25/20.
//  Copyright © 2020 Cesar Tesen. All rights reserved.
//

import Foundation

/// All types that implement this protocol must implement the JSONDecoder initializer
protocol JSONDecodable {
    // Initialize JSONDecoder class
    // JSON is inherently failable so we must throw
    init(_ decoder: JSONDecoder) throws
}

/// Lets us organize ourselves better, a dictionary that matches the structure of a JSON object.
typealias JSONObject = [String: Any]

/// Our list of possible parser errors
enum JSONParsingError: Error
{
    /// Unable to find the key
    case missingKey(key: String)
    /// Key specified doesn't match the target type
    case typeMismatch(key: String)
}

/// JSON Decoder class handles
class JSONDecoder
{
    // Initialize JSONObject
    let jsonObject: JSONObject
    init(_ jsonObject: JSONObject)
    {
        self.jsonObject = jsonObject
    }
    
    //
    func value<T>(forKey key: String) throws -> T
    {
        guard let value = jsonObject[key] else {
            throw JSONParsingError.missingKey(key: key)
        }
        guard let finalValue = value as? T else {
            throw JSONParsingError.typeMismatch(key: key)
        }
        return finalValue
    }

}

/// We use a generic parameter to deserialize different types of objects in the future.
/// The generic parameter must be JSON Decodable.
/// Parsing is failable too, so we throw errors to bubble up to the caller.
func parse<T>(_ data: Data) throws -> T where T: JSONDecodable
{
    // Data -> Any -> Object
    
    // Step 1: deserialize
    let jsonObject: JSONObject = try deserialize(data)
    // Step 2: decode
    // .map() lets us decode 1 object at a time rather than an entire collection
    // we return a NEW array of DECODED values of type T
    return try decode(jsonObject)
}

// Data -> Any
func deserialize(_ data: Data) throws -> JSONObject
{
    // Built in serialization class lets us put in the raw data and return an 'Any' object
    let json = try JSONSerialization.jsonObject(with: data, options: [])
    // Now we want to SAFELY cast ('as?') JSON type as an array of JSON objects
    guard let object = json as? JSONObject else { return [:] }
    // If we can successfully get a collection of objects, return it
    return object
}

// Any -> Object
func decode<T>(_ jsonObject: JSONObject) throws -> T where T: JSONDecodable
{
    // Initialize T and pass in a JSONDecoder object instance to initializer
    return try T.init(JSONDecoder(jsonObject))
}
