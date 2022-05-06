//
//  CharacterListViewController.swift
//  MarvelApp
//
//  Created by Maqueda, Ricardo Javier on 5/5/22.
//

import UIKit

class CharacterListViewController: UICollectionViewController {

    // MARK: Binding Clousures

    var onNextPage: (() -> Void)?
    var onSelect: ((MarvelCharacter) -> Void)?

    // MARK: Diffable DataSource

    private typealias DataSourceType = UICollectionViewDiffableDataSource<Int, MarvelCharacter>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Int, MarvelCharacter>

    func set(_ items: [MarvelCharacter]) {
        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    func append(_ items: [MarvelCharacter]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(items, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }

    private lazy var dataSource: DataSourceType = {
        .init(collectionView: collectionView) { collectionView, indexPath, model in
            let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
            cell.configure(with: model)

            return cell
        }
    }()

    // MARK: View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(ImageCollectionViewCell.self)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = dataSource
    }

    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    // MARK: CollectionView Delegate

    public override func collectionView(
        _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath
    ) {
        onSelect?(dataSource.itemIdentifier(for: indexPath)!)
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

}
