//
//  PostAsset.swift
//  NYT Instant
//
//  Created by Toualbi, Amine on 7/18/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import Foundation

class PostAsset {

    var imageURL: String
    var author: String
    var description: String
    var location: String
    var topic: String
    var desk: String
    var tags: [String]
    var articles: [ArticleAsset]

    init(postImageURL: String, postAuthor: String, postDescription: String, postLocation: String, postTopic: String, postDesk: String, postTags: [String], postArticles: [ArticleAsset]) {
        imageURL = postImageURL
        author = postAuthor
        description = postDescription
        location = postLocation
        topic = postTopic
        desk = postDesk
        tags = postTags
        articles = postArticles
    }

}

