//
//  DailySelectionTableCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 14.03.2022.
//

import Foundation
import UIKit

struct DailySelectionTableCellViewModel: RowViewModel {
    typealias Cell = DailySelectionTableCell
    
    let dataSource: [DayTitleCollectionCellViewModel]
    let index: Int
    let cellDidTap: (Int) -> ()
}

class DailySelectionTableCell: BaseTableViewCell {
    private var cellDidTap: (Int) -> Void = { _ in }
    
    private var dataSource: [DayTitleCollectionCellViewModel] = [] {
        didSet {
            colletionView.reloadData()
        }
    }

    private lazy var colletionView: UICollectionView = {
        let frame = CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 38)
        )

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 88, height: 36)
        layout.minimumInteritemSpacing = 12

        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.alwaysBounceHorizontal = true
        view.dataSource = self
        view.delegate = self
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.backgroundColor = .white
        view.allowsSelection = true

        view.register(cell: DayTitleCollectionCell.self)
        return view
    }()
    
    override func setupUI() {
        contentView.addSubview(colletionView)
        colletionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-40)
            make.height.equalTo(36)
        }
    }
}

extension DailySelectionTableCell: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = dataSource[indexPath.item]

        let cell = collectionView.dequeueReusableCell(viewModel.cellType, for: indexPath)
        cell.configure(viewModel: viewModel)

        return cell
    }
}

extension DailySelectionTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellDidTap(indexPath.item)
    }
}

extension DailySelectionTableCell {
    func configure(viewModel: DailySelectionTableCellViewModel) {
        dataSource = viewModel.dataSource
        cellDidTap = viewModel.cellDidTap
        
        selectedItemIfNeeded(index: viewModel.index)
    }
    
    func selectedItemIfNeeded(index: Int) {
        let selectedItems = colletionView.indexPathsForSelectedItems ?? []

        guard !selectedItems.contains(where: { $0.item == index }) else {
            return
        }
        
        colletionView.selectItem(
            at: IndexPath(item: index, section: 0),
            animated: true,
            scrollPosition: .centeredHorizontally
        )
    }
}

