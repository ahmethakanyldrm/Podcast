//
//  FavoriteCell.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 11.06.2023.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    // MARK: - Properties
    var podcastCoreData: PodcastCoreData? {
        didSet {
            configure()
        }
    }
    private let podcastImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.customMode()
        imageView.backgroundColor = .systemPurple
        return imageView
    }()
    
    private let podcastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Podcast Name"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()
    
    private let podcastArtistNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Podcast Artist Name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private var fullStackView: UIStackView!
    
    // MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selector
    
}

// MARK: - Helper

extension FavoriteCell {
    
    private func  configure() {
        guard let podcastCoreData = self.podcastCoreData else {return}
        let viewModel = FavoriteCellViewModel(podcastCoreData: podcastCoreData)
        self.podcastImageView.kf.setImage(with: viewModel.imageUrlPodcast)
        self.podcastNameLabel.text = viewModel.podcastNameLabel
        self.podcastArtistNameLabel.text = viewModel.podcastArtistNameLabel
        
    }

    
    private func style() {
        fullStackView = UIStackView(arrangedSubviews: [podcastImageView, podcastNameLabel, podcastArtistNameLabel])
        fullStackView.axis = .vertical
        fullStackView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        
        addSubview(fullStackView)
        
        NSLayoutConstraint.activate([
            podcastImageView.heightAnchor.constraint(equalTo: podcastImageView.widthAnchor),
            fullStackView.topAnchor.constraint(equalTo: topAnchor),
            fullStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            fullStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            fullStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
        
    }
}
