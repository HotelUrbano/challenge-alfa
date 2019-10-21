//
//  PackageDataSource.swift
//  Alpha
//
//  Created by Theo Mendes on 19/10/19.
//  Copyright © 2019 Hurb. All rights reserved.
//

import UIKit

/// A Data Source for the Package Collection View
class PackageDataSource: NSObject {
    // MARK: - Properties
    var items: [Deal] = []
    var width: CGFloat

    // MARK: - Lifecycle

    /**
    Initializes a new Package Data Source.

    - Parameters:
       - items: A Deal array to be shown in the collection view.

    - Returns: An initialized data source object.
    */
    init(with items: [Deal], width: CGFloat) {
        self.items = items
        self.width = width
    }
}

extension PackageDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Identifiers.Package.rawValue,
            for: indexPath) as? PackageCollectionViewCell else {
                fatalError("Unknown identifier")
        }
        cell.package = items[indexPath.row]
        cell.widthConstrant = width
        return cell
    }
}

extension PackageDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.width * (350 / 377)))
    }
}
