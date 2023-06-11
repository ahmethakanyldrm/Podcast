//
//  EpisodeCell.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 6.05.2023.
//

import UIKit

class EpisodeCell: UITableViewCell {
    // MARK: - Properties
    var episode: Episode? {
        didSet {
            configure()
        }
    }
    
    private let episodeImageView: UIImageView = {
        let img = UIImageView()
        img.customMode()
        img.backgroundColor = .systemPurple
        img.layer.cornerRadius = 12
        return img
    }()
    
    private let pubDateLabel: UILabel = {
       let label = UILabel()
        label.textColor = .systemPurple
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "pubDateLabel"
        return label
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "titleLabel"
        label.numberOfLines = 2
        return label
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "descriptionLabel"
        label.numberOfLines = 2
        return label
    }()
    
    private var stackView: UIStackView!
    
     var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.trackTintColor = .lightGray
        progressView.tintColor = .systemPurple
        progressView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        progressView.layer.cornerRadius = 12
        progressView.isHidden = true 
        progressView.setProgress(Float(0), animated: true)
        return progressView
    }()
    // MARK: - LifeCycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper

extension EpisodeCell {
    private func setup() {
        configureUI()
    }
    
    private func configureUI(){
        episodeImageView.translatesAutoresizingMaskIntoConstraints = false
        progressView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(episodeImageView)
        addSubview(progressView)
        
        NSLayoutConstraint.activate([
            episodeImageView.heightAnchor.constraint(equalToConstant: 100),
            episodeImageView.widthAnchor.constraint(equalToConstant: 100),
            episodeImageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            episodeImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            progressView.heightAnchor.constraint(equalToConstant: 20),
            progressView.leadingAnchor.constraint(equalTo: episodeImageView.leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: episodeImageView.trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: episodeImageView.bottomAnchor)
        ])
        
        stackView = UIStackView(arrangedSubviews: [pubDateLabel, titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            stackView.centerYAnchor.constraint(equalTo: episodeImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: episodeImageView.trailingAnchor,constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
            
        ])
    }
    
    private func configure() {
        guard let episode = self.episode else {return}
        let viewModel = EpisodeViewModel(episode: episode)
        self.episodeImageView.kf.setImage(with: viewModel.profileImageUrl)
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.pubDateLabel.text = viewModel.pubDate
        
    }
}
