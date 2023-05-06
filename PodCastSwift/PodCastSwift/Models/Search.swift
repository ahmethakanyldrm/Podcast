//
//  Search.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 5.05.2023.
//

import Foundation

struct Search: Decodable {
    let resultCount: Int
    let results: [Podcast]
}


