//
//  SearchService.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 5.05.2023.
//

import Foundation
import Alamofire

class SearchService {
    static func fetchData(searchText: String, completion: @escaping([Podcast])-> Void) {
        let baseUrl = "https://itunes.apple.com/search"
        let parameters = ["media":"podcast", "term": searchText]
        AF.request(baseUrl,parameters: parameters).responseData { response in
            if let error = response.error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = response.data else {return}
            do {
                let searchResult = try JSONDecoder().decode(Search.self, from: data)
                completion(searchResult.results)
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
