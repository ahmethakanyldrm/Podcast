//
//  MainTabbarController.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 5.05.2023.
//

import UIKit

class MainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}


// MARK: - Helper

extension MainTabbarController {
    private func setup() {
        viewControllers = [
            createViewController(rootViewController: FavoriteViewController(), title: "Favorites", imageName: "play.circle.fill"),
            createViewController(rootViewController: SearchViewController(), title: "Search", imageName: "magnifyingglass"),
            createViewController(rootViewController: DownloadsViewController(), title: "Downloads", imageName: "arrow.down.to.line")
            
        ]
    }
    
    private func createViewController(rootViewController: UIViewController, title: String, imageName: String) -> UINavigationController {
        rootViewController.title = title
        let appearance = UINavigationBarAppearance()
        let controller = UINavigationController(rootViewController: rootViewController)
        appearance.configureWithDefaultBackground()
        controller.navigationBar.prefersLargeTitles = true
        controller.navigationBar.compactAppearance = appearance
        controller.navigationBar.standardAppearance = appearance
        controller.navigationBar.scrollEdgeAppearance = appearance
        controller.navigationBar.compactScrollEdgeAppearance = appearance
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: imageName)
        return controller
    }
}
