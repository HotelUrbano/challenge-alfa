//
//  PackageTableViewCell.swift
//  Alpha
//
//  Created by Theo Mendes on 19/10/19.
//  Copyright © 2019 Hurb. All rights reserved.
//

import UIKit
import SnapKit

class PackageTableViewCell: BaseTableViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties

    var currentDataSource: UICollectionViewDataSource? {
        didSet {
            self.collectionView.dataSource = currentDataSource
            self.collectionView.reloadData()
        }
    }

    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 300, height: 360)
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        view.register(PackageCollectionViewCell.self,
                      forCellWithReuseIdentifier: Identifiers.Package.rawValue)
        return view
    }()

    // MARK: - View methods

    override func setupUI() {
        self.contentView.addSubview(collectionView)
    }

    override func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.0)
            make.height.equalTo(348).priority(999)
        }
    }
}
