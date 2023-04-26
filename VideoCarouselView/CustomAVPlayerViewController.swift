//
//  CustomAVPlayerViewController.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import AVKit

class CustomAVPlayerViewController: AVPlayerViewController {
    var isPlaying: Bool = true
    var currentTime: Double = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: .main) { [weak self] time in
            self?.currentTime = CMTimeGetSeconds(time)
        }

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        isPlaying.toggle()

        if isPlaying {
            player?.play()
        } else {
            player?.pause()
        }
    }
}

