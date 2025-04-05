//
//  JsonHealper.swift
//  iOS Quiz
//
//  Created by Rezaul Islam on 5/4/25.
//

import Foundation
import Combine

/// A generic function to load and decode JSON files from the app bundle
/// - Parameters:
///   - filename: Name of the JSON file without extension
///   - type: The Codable type to decode the JSON into
///   - bundle: The bundle containing the JSON file (defaults to main bundle)
/// - Returns: A publisher that emits the decoded object or an error
public func loadJSON<T: Decodable>(filename: String, as type: T.Type, bundle: Bundle = .main) -> AnyPublisher<T, Error> {
    
    return Future<T, Error> { promise in
        guard let path = bundle.path(forResource: filename, ofType: "json") else {
            promise(.failure(NSError(domain: "JSONLoader", code: 404,
                                    userInfo: [NSLocalizedDescriptionKey: "JSON file not found"])))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedObject = try decoder.decode(type, from: data)
            promise(.success(decodedObject))
        } catch {
            promise(.failure(error))
        }
    }
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()
}
