//
//  ArticleTableCell.swift
//  NYT-Instant
//
//  Created by Mieczkowski, Elizabeth on 7/17/19.
//  Copyright © 2019 Mieczkowski, Elizabeth. All rights reserved.
//
import UIKit

class ArticleCell: UITableViewCell {
    
    var articleHeadlineLabel: UILabel!
    var articleDateLabel: UILabel!
    var articleAuthorLabel: UILabel!
    var articleURL: String = ""
    let padding = 8
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(white: 0.20, alpha: 1.0)
        
        articleHeadlineLabel = UILabel()
        articleHeadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        articleHeadlineLabel.font = UIFont(name: "AmericanTypewriter-Bold", size: 18)
        articleHeadlineLabel.lineBreakMode = .byWordWrapping
        articleHeadlineLabel.numberOfLines = 0
        articleHeadlineLabel.textAlignment = .left
        articleHeadlineLabel.text = "" //TODO: fetch from data
        articleHeadlineLabel.clipsToBounds = true
        articleHeadlineLabel.textColor = .white
        contentView.addSubview(articleHeadlineLabel)
        
        articleDateLabel = UILabel()
        articleDateLabel.translatesAutoresizingMaskIntoConstraints = false
        articleDateLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        articleDateLabel.textAlignment = .left
        articleDateLabel.text = "" //TODO: fetch from data
        articleDateLabel.clipsToBounds = true
        articleDateLabel.textColor = .white
        contentView.addSubview(articleDateLabel)
        
        articleAuthorLabel = UILabel()
        articleAuthorLabel.translatesAutoresizingMaskIntoConstraints = false
        articleAuthorLabel.font = UIFont(name: "AppleSDGothicNeo-Light", size: 15)
        articleAuthorLabel.textAlignment = .left
        articleAuthorLabel.text = "" //TODO: fetch from data
        articleAuthorLabel.clipsToBounds = true
        articleAuthorLabel.textColor = .white
        contentView.addSubview(articleAuthorLabel)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            articleHeadlineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            articleHeadlineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            articleHeadlineLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            articleHeadlineLabel.heightAnchor.constraint(equalToConstant: 75)
            ])
        NSLayoutConstraint.activate([
            articleDateLabel.leadingAnchor.constraint(equalTo: articleHeadlineLabel.leadingAnchor),
            articleDateLabel.topAnchor.constraint(equalTo: articleHeadlineLabel.bottomAnchor, constant: 10),
            articleDateLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
        NSLayoutConstraint.activate([
            articleAuthorLabel.leadingAnchor.constraint(equalTo: articleDateLabel.trailingAnchor),
            articleAuthorLabel.topAnchor.constraint(equalTo: articleHeadlineLabel.bottomAnchor, constant: 10),
            articleAuthorLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

