//
//  UserDefaults+Ext.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 11.06.2023.
//

import Foundation

extension UserDefaults {
    static let downloadKey = "downloadedKey"
    
    static func downloadEpisodeWrite(episode: Episode) {
        
        do {
            var resultEpisodes = downloadEpisodeRead()
            resultEpisodes.append(episode)
            let data = try JSONEncoder().encode(resultEpisodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadKey)
        } catch  {
            print(error)
        }
    }
    
    static func downloadEpisodeRead() -> [Episode]{
        guard let data = UserDefaults.standard.data(forKey: UserDefaults.downloadKey) else {return []}
        do {
            let resultData = try JSONDecoder().decode([Episode].self, from: data)
            return resultData
        } catch  {
            print(error)
        }
        return []
    }
    
    
}
