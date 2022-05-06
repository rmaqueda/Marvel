//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit
import MarvelAPI

class CharacterListViewModel {
    private let view: CharacterListView
    private let characterRequest: CharacterRequest
    private var page = 0
    private var isLoading = false

    private enum Constants {
        static let requestLimit = 40
    }

    init(
        view: CharacterListView,
        session: URLSession = URLSession.shared
    ){
        self.view = view
        self.characterRequest = CharacterRequest(
            session: session,
            publicKey: Secrets.marvelPublicKey,
            privateKey: Secrets.marvelPrivateKey
        )
    }

    func showAllCharacters(offset: Int = 0) {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let data = try characterRequest.getAll(limit: Constants.requestLimit, offset: offset)
                let response = try CharacterMapper().decode(data: data)
                let viewModels = mapMarvelResponse(response)

                if page == 0 {
                    await view.set(viewModels)
                } else {
                    await view.append(viewModels)
                }
                page += 1
                isLoading = false
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }

    func nextPage() {
        showAllCharacters(offset: page * Constants.requestLimit)
    }

    private func mapMarvelResponse(_ response: CharactersResponse) -> [MarvelCharacter] {
        response.data.results.compactMap {
            guard
                !$0.thumbnail.path.contains("image_not_available"),
                let url = URL(string: $0.thumbnail.path + "." + $0.thumbnail.thumbnailExtension)
            else { return nil }

            return MarvelCharacter(
                id: $0.id,
                name: $0.name,
                imageURL: url
            )
        }
    }

}
