//
//  Episode.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 6.05.2023.
//

import Foundation
import FeedKit

struct Episode {
    let title: String
    let pubDate: Date
    let description: String
    let imageUrl: String
    let streamUrl: String
    let author:String
    
    init(value: RSSFeedItem) {
        self.author = value.iTunes?.iTunesAuthor?.description ?? value.author ?? ""
        self.title = value.title ?? ""
        self.pubDate = value.pubDate ?? Date()
        self.streamUrl = value.enclosure?.attributes?.url ?? ""
        self.description = value.iTunes?.iTunesSubtitle ?? value.description ?? ""
        self.imageUrl = value.iTunes?.iTunesImage?.attributes?.href ?? "https://cdn.pixabay.com/photo/2023/03/25/20/30/podcast-7876792_1280.jpg"
    }
}
