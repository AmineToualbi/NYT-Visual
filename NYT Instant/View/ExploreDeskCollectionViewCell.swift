//
//  ExploreDeskCollectionViewCell.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/16/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//
import UIKit

protocol ExploreAssetCellDelegate: class {
    func pushPhotoPage(for post: PostAsset)
}

class ExploreDeskCollectionViewCell: UICollectionViewCell {

    // Mark: - Cell Identifier
    static var identifier = "deskCollectionViewCell"

    // Mark: - properties
    let exploreAssetCollectionView = ExploreAssetCollectionView()
    var postAssets = [PostAsset]()
    weak var delegate: ExploreAssetCellDelegate?

    private lazy var sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Desk Title"
        label.font = UIFont(name: "NYTKarnakCondensed-Bold", size: 18)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor.clear
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDelegates()
        setupImageView()
        backgroundColor = UIColor(white: 0.20, alpha: 1.0)
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

    // Mark: - helper functions
    public func configureDeskCell(with deskName: String, and postAssets: [PostAsset]) {
        sectionTitleLabel.text = deskName
        self.postAssets = postAssets
    }
}

// Mark: - Delegate methods
extension ExploreDeskCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postAssets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExploreAssetCollectionViewCell.identifier, for: indexPath) as! ExploreAssetCollectionViewCell
        let postAsset = postAssets[indexPath.row]
        cell.configureAssetCell(with: postAsset.imageURL)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let post = postAssets[indexPath.row]
//        let post = posts[indexPath.item]

        didSelect(post)
    }


    private func didSelect(_ asset: PostAsset) {
        delegate?.pushPhotoPage(for: asset)
    }
}
