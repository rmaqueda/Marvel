//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import Foundation

struct CharacterDetailViewModel {
    let viewController: CharacterDetailViewController

    init(viewController: CharacterDetailViewController, character: CharacterListViewModel.Character) {
        self.viewController = viewController
        viewController.title = character.name
    }
}
