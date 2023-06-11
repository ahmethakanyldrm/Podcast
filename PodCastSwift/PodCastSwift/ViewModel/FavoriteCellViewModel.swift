//
//  FavoriteCellViewModel.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 11.06.2023.
//

import Foundation

struct FavoriteCellViewModel {
    var podcastCoreData: PodcastCoreData!
    init(podcastCoreData: PodcastCoreData!) {
        self.podcastCoreData = podcastCoreData
    }
    
    var imageUrlPodcast: URL? {
        return URL(string: podcastCoreData.artworkUrl600 ?? "")
    }
    
    var podcastNameLabel: String? {
        return podcastCoreData.trackName
    }
    
    var podcastArtistNameLabel: String? {
        return podcastCoreData.artistName
    }
}
