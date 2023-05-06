//
//  EpisodeViewController.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 6.05.2023.
//

import UIKit

class EpisodeViewController: UITableViewController {
    
    // MARK: - Properties
    private let reuseIdentifier = "EpisodeCell"
    private var podcast: Podcast
    
    // MARK: - LifeCycles
     init(podcast: Podcast) {
         self.podcast = podcast
         super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchData()
    }
}

extension EpisodeViewController {
    
    fileprivate func fetchData() {
        EpisodeService.fetchData(urlString: self.podcast.feedUrl!)
    }
}

// MARK: - Helper
extension EpisodeViewController {
    private func setup(){
        self.navigationItem.title = podcast.trackName
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource

extension EpisodeViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! EpisodeCell
        return cell
    }
}
