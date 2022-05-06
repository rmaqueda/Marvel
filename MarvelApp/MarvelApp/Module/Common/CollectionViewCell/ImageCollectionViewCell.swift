//
//  ImageCollectionViewCell.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var dataTask: URLSessionDataTask?

    override func prepareForReuse() {
        dataTask?.cancel()
        imageView.image = nil
    }

    func configure(with character: MarvelCharacter) {
        activityIndicator.startAnimating()
        downloadImage(from: character.imageURL)
    }

    func downloadImage(from url: URL) {
        dataTask = URLSession.bigCache.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async { [weak self] in
                self?.activityIndicator.stopAnimating()
                self?.imageView.image = UIImage(data: data)
            }
        }
        dataTask?.resume()
    }
    
}
