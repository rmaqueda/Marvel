//
//  SimpleLayout.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 6/5/22.
//

import UIKit

struct SimpleLayout {

    static var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()

        let width = UIScreen.main.bounds.size.width / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0

        return layout
    }

}
