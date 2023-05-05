//
//  FavoriteViewController.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 5.05.2023.
//

import UIKit

class FavoriteViewController: UIViewController {
    // MARK: - Properties
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}

// MARK: - Helper

extension FavoriteViewController{
    private func style() {
        view.backgroundColor = .blue
    }
    
    private func layout(){
        
    }
}
