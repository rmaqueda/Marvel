//
//  CharacterMapper.swift
//  MarvelAPI
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import Foundation

public class CharacterMapper {
    private lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    public init() { } 

    public func map(data: Data) throws -> CharactersResponse {
        try decoder.decode(CharactersResponse.self, from: data)
    }
}
