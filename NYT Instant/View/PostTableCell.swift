//
//  PostTableCell.swift
//  NYT Instant
//
//  Created by Toualbi, Amine on 7/17/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import UIKit
import PINRemoteImage

//Class for customizable cell.
class PostTableCell: UITableViewCell {
    
    //Elements that compose the UI of our cell.
    var photo: UIImageView!
    var topicLabel: UILabel!
    var authorLabel: UILabel!
    var locationLabel: UILabel!
    var markerImageView: UIImageView!
    var descriptionLabel: UILabel!
    var separatorView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(white: 0.20, alpha: 1.0)
        
        photo = UIImageView(frame: .zero)       //No line around the picture.
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.contentMode = .scaleAspectFill        //Fill the constraints of the ImageView
        photo.clipsToBounds = true
        photo.image = UIImage(named: "womensworldcupphoto")
        contentView.addSubview(photo)
        
        topicLabel = UILabel(frame: .zero)      //No line around the picture.
        topicLabel.translatesAutoresizingMaskIntoConstraints = false
        topicLabel.contentMode = .scaleAspectFill
        topicLabel.clipsToBounds = true
        topicLabel.textColor = .white
        guard let customFont = UIFont(name: "NYTKarnakCondensed-Bold", size: UIFont.labelFontSize + 6) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        topicLabel.font = UIFontMetrics.default.scaledFont(for: customFont)
        topicLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(topicLabel)
        
        authorLabel = UILabel(frame: .zero)   //No line around the picture.
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.contentMode = .scaleAspectFill
        authorLabel.clipsToBounds = true
     //   authorLabel.text = "Photo by Richard Heathcote"
        authorLabel.textColor = .white
        guard let customFont1 = UIFont(name: "NYTFranklin-Bold", size: 9) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        authorLabel.font = UIFontMetrics.default.scaledFont(for: customFont1)
        authorLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(authorLabel)
        
        locationLabel = UILabel(frame: .zero)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.contentMode = .scaleAspectFit
        locationLabel.clipsToBounds = true
      //  locationLabel.text = "Decines, France"
        locationLabel.lineBreakMode = .byWordWrapping        //So that if description is too long
        locationLabel.numberOfLines = 0                      //we don't crop the sentence & just go to the next line.
        locationLabel.textColor = .white
        guard let customFont2 = UIFont(name: "NYTFranklin-Bold", size: 9) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        locationLabel.font = UIFontMetrics.default.scaledFont(for: customFont2)
        locationLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(locationLabel)

        markerImageView = UIImageView(frame: .zero)
        markerImageView.translatesAutoresizingMaskIntoConstraints = false
        markerImageView.contentMode = .scaleAspectFill
        markerImageView.clipsToBounds = true
        markerImageView.image = UIImage(named: "map-marker-alt")
        contentView.addSubview(markerImageView)
        
        descriptionLabel = UILabel(frame: .zero)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.contentMode = .scaleAspectFill
        descriptionLabel.clipsToBounds = true
        //descriptionLabel.text = "Megan Rapinoe celebrating after winning the Women's World Cup final on Sunday."
        descriptionLabel.lineBreakMode = .byWordWrapping        //So that if description is too long
        descriptionLabel.numberOfLines = 0                      //we don't crop the sentence & just go to the next line.
        descriptionLabel.textColor = UIColor(white: 0.50, alpha: 1.0)
        guard let customFont3 = UIFont(name: "NYTFranklin-Medium", size: 12) else {
            fatalError("""
        Failed to load the "whatever u wrote" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """
            )
        }
        descriptionLabel.font = UIFontMetrics.default.scaledFont(for: customFont3)
        descriptionLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(descriptionLabel)
        
            separatorView = UIView()
            separatorView.backgroundColor = .black
            separatorView.translatesAutoresizingMaskIntoConstraints = false
            separatorView.contentMode = .scaleAspectFill
            separatorView.clipsToBounds =  true
            contentView.addSubview(separatorView)
    
        
        setupConstraints()
     
    }
    
    //When using top & bottom constraints, write safeAreaLayoutGuide to avoid having view over battery.
    //AutoLayout function.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            photo.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            photo.heightAnchor.constraint(equalToConstant: 250),
            photo.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)])
        
        NSLayoutConstraint.activate([
            topicLabel.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 20),
            topicLabel.heightAnchor.constraint(equalToConstant: 20),
            topicLabel.leadingAnchor.constraint(equalTo: photo.leadingAnchor, constant: 20),
            topicLabel.trailingAnchor.constraint(equalTo: photo.trailingAnchor)
            ])
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: topicLabel.bottomAnchor, constant: 3),
            authorLabel.heightAnchor.constraint(equalToConstant: 14),
            authorLabel.leadingAnchor.constraint(equalTo: topicLabel.leadingAnchor),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
            ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: topicLabel.topAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 14),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -115)
            ])
        
        NSLayoutConstraint.activate([
            markerImageView.topAnchor.constraint(equalTo: locationLabel.topAnchor),
            markerImageView.heightAnchor.constraint(equalToConstant: 12),
            markerImageView.widthAnchor.constraint(equalToConstant: 9),
            markerImageView.trailingAnchor.constraint(equalTo: locationLabel.leadingAnchor, constant: -7)])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            ])
        
            NSLayoutConstraint.activate([
                separatorView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                separatorView.heightAnchor.constraint(equalToConstant: 20),
                separatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                separatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
                ])

    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
