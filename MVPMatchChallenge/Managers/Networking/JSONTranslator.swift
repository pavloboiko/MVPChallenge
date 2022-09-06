//
//  JSONTranslator.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//


import Foundation

/// TranslationLayer Protocol
protocol TranslationLayer {
    func translateToObject<T: Decodable>(withData data: Data) throws -> T
}

/// TranslationLayer Protocol Implmentation
class JSONTranslation: TranslationLayer {
    
    func translateToObject<T: Decodable>(withData data: Data) throws -> T {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
    }
}
