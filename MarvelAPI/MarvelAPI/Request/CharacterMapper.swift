//
//  CharacterMapper.swift
//  MarvelAPI
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import Foundation

public class CharacterMapper {
    public init() { } 

    public func decode(data: Data) throws -> CharactersResponse {
        try DefaultDecoder.decode(CharactersResponse.self, from: data)
    }
}
