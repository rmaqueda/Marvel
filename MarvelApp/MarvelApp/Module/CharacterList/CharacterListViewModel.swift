//
//  CharacterListViewModel.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit
import MarvelAPI

class CharacterListViewModel {
    struct Character: Hashable {
        let id: Int
        let name: String
        let imageURL: String

        static func == (lhs: Character, rhs: Character) -> Bool {
          lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
          hasher.combine(id)
        }
    }

    let viewController: CharacterListViewController
    private let marvelAPI = CharacterRequest(
        publicKey: Secrets.marvelPublicKey,
        privateKey: Secrets.marvelPrivateKey
    )
    private let characterMapper = CharacterMapper()
    private var pageNumber = 0
    private var isLoading = false

    private struct Constants {
        static let requestLimit = 20
    }

    init(viewController: CharacterListViewController) {
        self.viewController = viewController
    }

    func showAllCharacters(offset: Int = 0) {
        isLoading = true
        Task {
            do {
                let data = try marvelAPI.getAll(limit: Constants.requestLimit, offset: offset)
                let charactersResponse = try characterMapper.map(data: data)
                let viewModels = charactersResponse.data.results.map {
                    Character(
                        id: $0.id,
                        name: $0.name,
                        imageURL: $0.thumbnail.path + "." + $0.thumbnail.thumbnailExtension
                    )
                }

                if pageNumber == 0 {
                    await viewController.set(viewModels)
                } else {
                    await viewController.append(viewModels)
                }
                pageNumber += 1
                isLoading = false
            } catch {
                print("Error \(error)")
            }
        }
    }

    func loadNextPage() {
        guard !isLoading else { return }
        showAllCharacters(offset: pageNumber * Constants.requestLimit)
    }
}
