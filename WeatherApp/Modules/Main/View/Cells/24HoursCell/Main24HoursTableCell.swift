//
//  Main24HoursTableCell.swift
//  WeatherApp
//
//  Created by Sergey Balashov on 21.02.2022.
//

import UIKit

struct Main24HoursViewModel: RowViewModel {
    typealias Cell = Main24HoursTableCell
    
    let dataSource: [HourDetailWeatherCellViewModel]
    let detailButtonAction: () -> ()
}

class Main24HoursTableCell: BaseTableViewCell {
    @objc private var detailButtonAction: () -> () = {}
    private var dataSource: [HourDetailWeatherCellViewModel] = [] {
        didSet {
            colletionView.reloadData()
        }
    }
    
    private lazy var colletionView: UICollectionView = {
        let frame = CGRect(
            origin: .zero,
            size: CGSize(width: UIScreen.main.bounds.width, height: 80)
        )
                
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 42, height: 83)
        layout.minimumInteritemSpacing = 8
        
        let view = UICollectionView(frame: frame, collectionViewLayout: layout)
        view.alwaysBounceHorizontal = true
        view.dataSource = self
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        view.backgroundColor = .white
        
        view.register(cell: HourDetailWeatherCell.self)
        return view
    }()
    
    private lazy var detailButton: UIButton = {
        let view = UIButton(type: .system)
        
        let attributedText = NSMutableAttributedString(
            string: "Подробнее на 24 часа",
            attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue,
                         .font: UIFont.regular,
                         .foregroundColor: UIColor.black]
        )

        view.setAttributedTitle(attributedText, for: .normal)
        view.addTarget(self, action: #selector(detailButtonTap), for: .touchUpInside)
        return view
    }()
    
    override func setupUI() {
        contentView.addSubview(detailButton)
        detailButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        contentView.addSubview(colletionView)
        colletionView.snp.makeConstraints { make in
            make.top.equalTo(detailButton.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(83)
        }
    }
    
    @objc private func detailButtonTap() {
        detailButtonAction()
    }
}

extension Main24HoursTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = dataSource[indexPath.item]
        
        let cell = collectionView.dequeueReusableCell(viewModel.cellType, for: indexPath)
        cell.configure(viewModel: viewModel)
        
        return cell
    }
}

extension Main24HoursTableCell {
    func configure(viewModel: Main24HoursViewModel) {
        dataSource = viewModel.dataSource
        detailButtonAction = viewModel.detailButtonAction
    }
}
