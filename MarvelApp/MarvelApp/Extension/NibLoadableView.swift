//
//  NibLoadableView.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView {
    static var nibName: String { String(describing: self) }
}

extension UICollectionViewCell: NibLoadableView { }
