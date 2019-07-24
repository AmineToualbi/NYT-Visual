//
//  ExploreDeskCollectionViewCell.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/16/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit

class ExploreDeskCollectionViewCell: UICollectionViewCell {

    // Mark: - Cell Identifier
    static var identifier = "deskCollectionViewCell"

    // Mark: - properties
    let exploreAssetCollectionView = ExploreAssetCollectionView()

    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Desk Title"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDelegates()
        setupImageView()
        backgroundColor = UIColor.darkGray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - methods
    private func setupDelegates() {
        exploreAssetCollectionView.assetCollectionView.dataSource = self
        exploreAssetCollectionView.assetCollectionView.delegate = self
    }


    // MARK: - Constraints
    private func setupImageView() {
        addSubview(exploreAssetCollectionView)
        addSubview(sectionTitleLabel)
        exploreAssetCollectionView.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": sectionTitleLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v1": exploreAssetCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(45)]-0-[v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": sectionTitleLabel, "v1": exploreAssetCollectionView]))
    }
}

// Mark: - Delegate methods
extension ExploreDeskCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreAssetCollectionViewCell.identifier, for: indexPath) as! ExploreAssetCollectionViewCell

        return cell
    }
}

extension ExploreDeskCollectionViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 140)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}


