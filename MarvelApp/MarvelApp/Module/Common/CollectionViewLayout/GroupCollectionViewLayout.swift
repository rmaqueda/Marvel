//
//  GroupCollectionViewLayout.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 6/5/22.
//

import UIKit

struct GroupCollectionViewLayout {

    static var layout: UICollectionViewCompositionalLayout {
        let isLandscape = false
        let size = UIScreen.main.bounds.size
        return UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection? in

            let leadingItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.5),
                heightDimension: .fractionalHeight(1.0))

            let leadingItem = NSCollectionLayoutItem(layoutSize: leadingItemSize)
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            let trailingItemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.3))
            let trailingItem = NSCollectionLayoutItem(layoutSize: trailingItemSize)
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)

            let trailingLeftGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.25),
                    heightDimension: .fractionalHeight(1.0)),
                subitem: trailingItem, count: 2
            )

            let trailingRightGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.25),
                    heightDimension: .fractionalHeight(1.0)),
                subitem: trailingItem, count: 2
            )

            let fractionalHeight: NSCollectionLayoutDimension =
            isLandscape ? .fractionalHeight(0.8) : .fractionalHeight(0.4)

            let groupDimensionHeight: NSCollectionLayoutDimension = fractionalHeight

            let rightGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: groupDimensionHeight),
                subitems: [leadingItem, trailingLeftGroup, trailingRightGroup]
            )

            let leftGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: groupDimensionHeight),
                subitems: [trailingRightGroup, trailingLeftGroup, leadingItem]
            )

            let height = isLandscape ? size.height / 0.9 : size.height / 1.25
            let megaGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .estimated(height)),
                subitems: [rightGroup, leftGroup]
            )

            return NSCollectionLayoutSection(group: megaGroup)
        }
    }

}
