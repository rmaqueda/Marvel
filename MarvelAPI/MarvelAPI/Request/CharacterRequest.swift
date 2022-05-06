//
//  CharacterRequest.swift
//  
//
//  Created by Maqueda, Ricardo Javier on 29/4/22.
//

import Foundation

public struct CharacterRequest {
    private var timeProvider: () -> Date
    private let charactersURL = URL(string: "https://gateway.marvel.com/v1/public/characters")!
    private let publicKey: String
    private let privateKey: String
    private let session: URLSession

    public init(
        session: URLSession = URLSession.shared,
        publicKey: String,
        privateKey: String,
        timeProvider: @escaping () -> Date = { Date() }
    ) {
        self.session = session
        self.publicKey = publicKey
        self.privateKey = privateKey
        self.timeProvider = timeProvider
    }

    public enum Error: Swift.Error {
        case invalidLimit
        case emptyData
        case networkError
    }

    public func getAll(limit: Int? = nil, offset: Int? = nil) throws -> Data {
        try characterRequest(limit: limit, offset: offset)
    }

    public func get(id: Int) throws -> Data {
        try characterRequest(id: id)
    }

    private func characterRequest(
        id: Int? = nil,
        limit: Int? = nil,
        offset: Int? = nil
    ) throws -> Data {
        let finalURL = id != nil ? charactersURL.appendingPathComponent(String(id!)) : charactersURL

        let group = DispatchGroup()
        group.enter()

        var resultData: Data?
        var resultError: Error?

        let url = try addQueryItems(url: finalURL, limit: limit, offset: offset)
        session.dataTask(with: url) { data, response, _ in
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
        guard let resultData = resultData, !resultData.isEmpty else {
            throw Error.emptyData
        }

        return resultData
    }


    private func addQueryItems(url: URL, limit: Int?, offset: Int?) throws -> URL {
        let timestamp = String(Int(timeProvider().timeIntervalSince1970))
        let apiKey = URLQueryItem(name: "apikey", value: publicKey)
        let timestampQuery = URLQueryItem(name: "ts", value: timestamp)
        let hash = URLQueryItem(name: "hash", value: (timestamp + privateKey + publicKey).MD5)

        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [timestampQuery, apiKey, hash]

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

        return components.url!
    }

}
