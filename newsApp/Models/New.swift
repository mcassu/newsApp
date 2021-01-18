//
//  Article.swift
//  GoodNews
//
//  Created by Cassu on 13/01/21.
//  Copyright © 2021 Cassu. All rights reserved.
//

import Foundation

struct NewsList: Decodable {
    let articles: [New]
}

struct New: Decodable {
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}
