//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit
import MarvelAPI

class CharacterListViewModel {
    private let viewController: CharacterListViewController
    private let marvelAPI = CharacterRequest(
        publicKey: Secrets.marvelPublicKey,
        privateKey: Secrets.marvelPrivateKey
    )
    private let characterMapper = CharacterMapper()
    private var page = 0
    private var isLoading = false

    private enum Constants {
        static let requestLimit = 40
    }

    init(viewController: CharacterListViewController) {
        self.viewController = viewController
    }

    func showAllCharacters(offset: Int = 0) {
        isLoading = true
        Task {
            do {
                let data = try marvelAPI.getAll(limit: Constants.requestLimit, offset: offset)
                let response = try characterMapper.map(data: data)
                let viewModels = mapMarvelResponse(response)

                if page == 0 {
                    await viewController.set(viewModels)
                } else {
                    await viewController.append(viewModels)
                }
                page += 1
                isLoading = false
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func nextPage() {
        guard !isLoading else { return }
        showAllCharacters(offset: page * Constants.requestLimit)
    }

    private func mapMarvelResponse(_ response: CharactersResponse) -> [MarvelCharacter] {
        response.data.results.compactMap {
            guard !$0.thumbnail.path.contains("image_not_available") else { return nil }

            return MarvelCharacter(
                id: $0.id,
                name: $0.name,
                imageURL: $0.thumbnail.path + "." + $0.thumbnail.thumbnailExtension
            )
        }
    }

}
