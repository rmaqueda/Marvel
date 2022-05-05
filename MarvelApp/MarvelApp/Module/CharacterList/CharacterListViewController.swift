//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit

class CharacterListViewController: UICollectionViewController {
    var onNextPage: (() -> Void)?
    var onSelect: ((CharacterListViewModel.Character) -> Void)?

    func set(_ newItems: [CharacterListViewModel.Character]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CharacterListViewModel.Character>()
        snapshot.appendSections([0])
        snapshot.appendItems(newItems, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func append(_ newItems: [CharacterListViewModel.Character]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(newItems, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Int, CharacterListViewModel.Character> = {
        .init(collectionView: collectionView) { collectionView, indexPath, controller in
            let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: controller)

            return cell
        }
    }()

    // MARK: Life cycle


    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ImageCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = dataSource
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: ScrollView Delegate

    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.isDragging else { return }

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            onNextPage?()
        }
    }

    public override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = dataSource.itemIdentifier(for: indexPath) else { return }
        onSelect?(model)
    }

}
