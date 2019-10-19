//
//  HotelTableViewCell.swift
//  Alpha
//
//  Created by Theo Mendes on 18/10/19.
//  Copyright © 2019 Hurb. All rights reserved.
//

import UIKit
import SnapKit

class StarTableViewCell: BaseTableViewCell {
    var currentDataSource: UICollectionViewDataSource? {
        didSet {
            self.collectionView.dataSource = currentDataSource
            self.collectionView.reloadData()
        }
    }

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 205, height: 260)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(HotelCollectionViewCell.self, forCellWithReuseIdentifier: Identifiers.Hotels.rawValue)
        return view
    }()

    override func setupUI() {
        self.contentView.addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.0)
            make.height.equalTo(263).priority(999)
        }
    }
}
