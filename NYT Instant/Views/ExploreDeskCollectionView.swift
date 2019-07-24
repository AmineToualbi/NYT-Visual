//
//  ExploreDeskCollectionView.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/17/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit

class ExploreDeskCollectionView: UIView {

    // Mark: - Lazy Variables
    lazy var deskCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        cv.backgroundColor = .black
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        cv.register(ExploreDeskCollectionViewCell.self, forCellWithReuseIdentifier: ExploreDeskCollectionViewCell.identifier)
        return cv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - Setup Methods
    private func setupViews() {
        setupCollectionView()
    }

    // Mark: - constraints
    private func setupCollectionView() {
        addSubview(deskCollectionView)
        deskCollectionView.translatesAutoresizingMaskIntoConstraints = false
        deskCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        deskCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        deskCollectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        deskCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        deskCollectionView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}

