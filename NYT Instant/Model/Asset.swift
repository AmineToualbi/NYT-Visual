//
//  Asset.swift
//  NYT Instant
//
//  Created by Mejia, Clint on 7/17/19.
//  Copyright © 2019 Toualbi, Amine. All rights reserved.
//

import Foundation

struct Desk: Codable {
    let asset: [Asset]
}

struct Asset: Codable {
    let dateTaken: String
    let url: String
    let location: String
    let description: String
    let photographer: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case dateTaken = "date_taken"
        case url = "image_url"
        case location
        case description
        case photographer
        case tags
    }
}
