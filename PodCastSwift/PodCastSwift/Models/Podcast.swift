//
//  Podcast.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 6.05.2023.
//

import Foundation

struct Podcast: Decodable{
    var trackName: String?
    var artistName: String?
    var trackCount: Int?
    var artworkUrl600: String?
    var feedUrl: String?
}
