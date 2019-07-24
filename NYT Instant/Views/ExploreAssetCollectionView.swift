//
//  ExploreAssetCollectionView.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/18/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit

class ExploreAssetCollectionView: UIView {

    // Mark: - Lazy Variables
    lazy var assetCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .darkGray
        layout.minimumLineSpacing = 20
        collectionView.register(ExploreAssetCollectionViewCell.self, forCellWithReuseIdentifier: ExploreAssetCollectionViewCell.identifier)
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - setup functions
    private func setupViews() {
        setupCollectionView()
    }

    // Mark: - constraints
    private func setupCollectionView() {
        addSubview(assetCollectionView)
        assetCollectionView.translatesAutoresizingMaskIntoConstraints = false
        assetCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        assetCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        assetCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        assetCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        assetCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

