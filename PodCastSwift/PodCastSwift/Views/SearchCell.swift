//
//  SearchCell.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 5.05.2023.
//

import UIKit
import Kingfisher

class SearchCell: UITableViewCell {
    // MARK: - Properties
    
    var result: Podcast? {
        didSet {
            configure()
        }
    }
    
    private let photoImageView: UIImageView = {
       
        let img = UIImageView()
        img.backgroundColor = .systemPurple
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let trackName: UILabel = {
       let lbl = UILabel()
        lbl.text = "Track Name"
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        return lbl
    }()
    
    private let artistName: UILabel = {
       let lbl = UILabel()
        lbl.text = "Artist Name"
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        return lbl
    }()
    
    private let trackCount: UILabel = {
       let lbl = UILabel()
        lbl.text = "Track Count"
        lbl.textColor = .gray
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        return lbl
    }()
    
    private var stackView: UIStackView!
    
    // MARK: - LifeCycles
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Helper
extension SearchCell {
    private func setup() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        photoImageView.layer.cornerRadius = 12
        stackView = UIStackView(arrangedSubviews: [trackName, artistName, trackCount])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
    }
    
    private func layout(){
        
        addSubview(photoImageView)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            photoImageView.heightAnchor.constraint(equalToConstant: 80),
            photoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            stackView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
            
        ])
        
    }
    
    private func configure() {
        guard let result = self.result else {return}
        let viewModel = SearchViewModel(podcast: result)
        trackName.text = viewModel.trackName
        trackCount.text = viewModel.trackCountString
        artistName.text = viewModel.artistName
        photoImageView.kf.setImage(with: viewModel.photoImageUrl)
    }
}
