//
//  MarvelCharacter.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 6/5/22.
//

import Foundation

struct MarvelCharacter: Hashable {
    let id: Int
    let name: String
    let imageURL: String

    static func == (lhs: MarvelCharacter, rhs: MarvelCharacter) -> Bool {
      lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
}
