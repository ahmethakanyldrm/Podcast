//
//  PlayerViewController.swift
//  PodCastSwift
//
//  Created by AHMET HAKAN YILDIRIM on 7.05.2023.
//

import UIKit
import AVKit

class PlayerViewController: UIViewController {
    // MARK: - Properties
    
    var episode: Episode
    
    private var mainStackView: UIStackView!
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
        return button
    }()
    
    private let episodeImageView: UIImageView = {
       let img = UIImageView()
        img.customMode()
        img.layer.cornerRadius = 12
        img.backgroundColor = .systemPurple
        
        return img
    }()
    
    private let sliderView: UISlider = {
       let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        return slider
    }()
    
    private let startLabel: UILabel = {
       let label = UILabel()
        label.text = "00 : 00"
        label.textAlignment = .left
        return label
    }()
    
    private let endLabel: UILabel = {
       let label = UILabel()
        label.text = "00 : 00"
        label.textAlignment = .right
        return label
    }()
    
    private var timerStackView: UIStackView!
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "name"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
        return label
    }()
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.text = "name"
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private var playStackView: UIStackView!
    
    private lazy var goForWardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "goforward.30"), for: .normal)
        button.customAlignment()
        button.addTarget(self, action: #selector(handleGoForwardButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var goPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.addTarget(self, action: #selector(handleGoPlayButton), for: .touchUpInside)
        button.customAlignment()
        return button
    }()
    
    private lazy var goBackWardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "gobackward.15"), for: .normal)
        button.addTarget(self, action: #selector(handleBackForwardButton), for: .touchUpInside)
        button.customAlignment()
        return button
    }()
    
    private var volumeStackView: UIStackView!
    
    private lazy var volumeSliderView: UISlider = {
       let slider = UISlider()
        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.addTarget(self, action: #selector(handleVolumeSliderView), for: .valueChanged)
        return slider
    }()
    
    private let minusImageView: UIImageView = {
       
        let img = UIImageView()
        img.image = UIImage(systemName: "speaker.wave.1.fill")
        img.tintColor = .lightGray
        return img
    }()
    
    private let plusImageView: UIImageView = {
       
        let img = UIImageView()
        img.image = UIImage(systemName: "speaker.wave.3.fill")
        img.tintColor = .lightGray
        return img
    }()
    
    private let player: AVPlayer = {
       let player = AVPlayer()
        return player
    }()
    
    // MARK: - LifeCycles
    
    init(episode: Episode) {
        self.episode = episode
        super.init(nibName: nil, bundle: nil)
        style()
        layout()
        startPlay()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        player.pause()

    }
    
}

// MARK: - Selector
extension PlayerViewController {
    
    @objc private func handleGoPlayButton(_ sender: UIButton) {
        if player.timeControlStatus == .paused {
            player.play()
            self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }else {
            player.pause()
            goPlayButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
    }
    
   
    @objc private func handleCloseButton(_ sender: UIButton) {
        player.pause()
        self.dismiss(animated: true)
    }
    
    @objc private func handleGoForwardButton(_ sender: UIButton) {
       updateForward(value: 30)
    }
    
    @objc private func handleBackForwardButton(_ sender: UIButton) {
       updateForward(value: -15)
    }
    
    @objc private func handleVolumeSliderView(_ sender: UISlider) {
        player.volume = sender.value
        
    }
    
}

// MARK: - Helper

extension PlayerViewController {
    
    /// updateForward Fonksiyonu
    ///  Bu fonksiyon Podcasti ileri veya geri sarma işlemini yapar
    private func updateForward(value: Int64) {
        let exampleTime = CMTime(value: value, timescale: 1)
        let seekTime = CMTimeAdd(player.currentTime(), exampleTime)
        player.seek(to: seekTime)

    }
    
    /// updateSlider Fonksiyonu
    ///  Bu fonksiyon Podcastin süresi ilerledikçe veya geri sarıldıkça slider güncelleme işlemini yapar
    
    fileprivate func updateSlider() {
        let currentTimeSecond = CMTimeGetSeconds(player.currentTime())
        let durationTime = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let resultSecondTime = currentTimeSecond / durationTime
        self.sliderView.value = Float(resultSecondTime)
    }
    
   
    fileprivate func updateTimeLabel() {
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { time in
            self.startLabel.text = time.formatString()
            let endTimeSecond = self.player.currentItem?.duration
            self.endLabel.text = endTimeSecond?.formatString()
            self.updateSlider()
        }
    }
    
    /// playPodcast Fonksiyonu
    /// Bu fonksiyon Podcastin oynatılması, play butonunun görselinin pause moduna geçmesi ve süresinin başlatılması işlemini sağlar işlemini yapar
    ///  Ek olarak başlangıç ses düzeyini 40 olarak ayarlar
    private func playPodcast(url: URL){
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        self.goPlayButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        self.volumeSliderView.value = 40
        updateTimeLabel()
    }
    
   /// startPlay fonksiyonu
  ///  oynatılacak podcastin indirilip indirilmediğini kontrol eder.
 ///   indirildiyse internetsiz ortamda localden oynatır indirilmediyse internet ortamında oynatır
    private func startPlay() {
        
        if episode.fileUrl != nil {
            guard let url = URL(string: episode.fileUrl ?? "") else {return}
            guard var fileUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else{return}
            
            fileUrl.append(path: url.lastPathComponent)
            playPodcast(url: fileUrl)
        }
        guard let url = URL(string: episode.streamUrl) else {return}
        playPodcast(url: url)
    }
    
    /// Style Fonksiyonu
    /// Oluşturduğum Viewlar StackViewlar içerisine ekleme işlemi gerçekleştirir
    private func style() {
        view.backgroundColor = .white
        
        playStackView = UIStackView(arrangedSubviews: [goBackWardButton, UIView() ,goPlayButton, UIView() ,goForWardButton])
        playStackView.axis = .horizontal
        playStackView.distribution = .fillEqually
        
        volumeStackView = UIStackView(arrangedSubviews: [minusImageView, volumeSliderView, plusImageView])
        volumeStackView.axis = .horizontal
        
        timerStackView = UIStackView(arrangedSubviews: [startLabel, endLabel])
        timerStackView.axis = .horizontal
        
        let fullTimerStackView = UIStackView(arrangedSubviews: [sliderView, timerStackView])
        fullTimerStackView.axis = .vertical
        
        
        mainStackView = UIStackView(arrangedSubviews: [closeButton, episodeImageView, fullTimerStackView,UIView() , nameLabel, usernameLabel ,playStackView, volumeStackView])
        mainStackView.axis = .vertical
        mainStackView.distribution = .equalSpacing
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        print(episode)
    }
    
    /// Layout Fonksiyonu
    /// Constraintler Ayarlanır
    private func layout() {
        view.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            episodeImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            sliderView.heightAnchor.constraint(equalToConstant: 40),
            
            playStackView.heightAnchor.constraint(equalToConstant: 80),
            
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32),
            mainStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32)
            
        
        ])
    }
    
    private func configureUI() {
        self.episodeImageView.kf.setImage(with: URL(string: episode.imageUrl))
        self.nameLabel.text = episode.title
        self.usernameLabel.text = episode.author
    }
}
