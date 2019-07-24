//
//  ExploreAssetCollectionViewCell.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/18/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//
import UIKit
import Firebase

class ExploreAssetCollectionViewCell: UICollectionViewCell {

    // Mark: - Cell Identifier
    static var identifier = "exploreAssetCollectionViewCell"

    // Mark: - Lazy properties
    private lazy var assetImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor(white: 0.20, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.image = UIImage(imageLiteralResourceName: "womensworldcupphoto")
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Mark: - functions
    private func setupView() {
        addSubview(assetImageView)
        assetImageView.frame = CGRect(x:0, y: 0, width: 210, height: 140)
    }

    //reset image to prevent flickering
    private func resetImageView() {
        self.assetImageView.image = nil
    }

    func configureAssetCell(with string: String) {
        resetImageView()
        assetImageView.pin_setImage(from: URL(string: string))
    }
}
