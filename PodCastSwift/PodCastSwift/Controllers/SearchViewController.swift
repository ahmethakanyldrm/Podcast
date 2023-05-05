//
//  SearchViewController.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 5.05.2023.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    // MARK: - Properties
    
    private let reuseIdentifier = "SearchCell"
    var searchResult: [Podcast] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

// MARK: - Helper

extension SearchViewController{
    private func style() {
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 130
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func layout(){
        
    }
}

// MARK: - UITableViewDataSource

extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.result = self.searchResult[indexPath.row]
        return cell
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        SearchService.fetchData(searchText: searchText) { result in
            self.searchResult = result
        }
    }
}
