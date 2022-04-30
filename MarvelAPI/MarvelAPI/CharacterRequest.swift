//
//  File.swift
//  
//
//  Created by Maqueda, Ricardo Javier on 29/4/22.
//

import Foundation

public struct CharacterRequest {
    private let charactersURL = URL(string: "https://gateway.marvel.com/v1/public/characters")!
    private let publicKey: String
    private let privateKey: String
    private let session: URLSession
    
    public init(
        session: URLSession,
        publicKey: String,
        privateKey: String
    ) {
        self.session = session
        self.publicKey = publicKey
        self.privateKey = privateKey
    }
    
    public enum Error: Swift.Error {
        case invalidLimit
        case networkError
        case emptyData
    }
    
    public func getAll(
        timeProvider: (() -> Date) = { Date() },
        limit: Int = 20,
        offset: Int? = nil
    ) throws -> Data {
        try characterRequest(
            timeProvider: timeProvider,
            limit: limit,
            offset: offset
        )
    }
    
    public func get(
        timeProvider: (() -> Date) = { Date() },
        id: Int
    ) throws -> Data  {
        try characterRequest(id: id, timeProvider: timeProvider)
    }
    
    private func characterRequest(
        id: Int? = nil,
        timeProvider: (() -> Date) = { Date() },
        limit: Int? = nil,
        offset: Int? = nil
    ) throws -> Data {
        var finalURL = charactersURL
        if let id = id {
            finalURL.appendPathComponent(String(id))
        }
        if let limit = limit, limit > 100 {
            throw Error.invalidLimit
        }
        
        let group = DispatchGroup()
        group.enter()
        
        var resultData: Data?
        var resultError: Error?
        
        let timestamp = String(Int(timeProvider().timeIntervalSince1970))
        let apiKey = URLQueryItem(name: "apikey", value: publicKey)
        let ts = URLQueryItem(name: "ts", value: timestamp)
        let hash = URLQueryItem(name: "hash", value: (timestamp + privateKey + publicKey).MD5)
        
        var components = URLComponents(url: finalURL, resolvingAgainstBaseURL: false)!
        components.queryItems = [ts, apiKey, hash]
        
        if let limit = limit {
            if limit > 100 {
                throw Error.invalidLimit
            }
            let limitParam = URLQueryItem(name: "limit", value: String(limit))
            components.queryItems?.append(limitParam)
        }
        
        if let offset = offset {
            components.queryItems?.append(URLQueryItem(name: "offset", value: String(offset)))
        }
        
        session.dataTask(with: components.url!) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 200 {
                resultData = data
            } else {
                resultError = Error.networkError
            }
            
            group.leave()
        }.resume()
        
        group.wait()
        
        if let error = resultError {
            throw error
        }
        guard let resultData = resultData else {
            throw Error.emptyData
        }
        
        return resultData
    }
}
