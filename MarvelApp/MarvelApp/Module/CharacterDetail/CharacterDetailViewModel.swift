//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import Foundation

struct CharacterDetailViewModel {
    let view: CharacterDetailViewController

    init(view: CharacterDetailViewController, character: MarvelCharacter) {
        self.view = view
        view.title = character.name
    }
}
