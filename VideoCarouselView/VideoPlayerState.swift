//
//  VideoPlayerState.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import Combine
import AVFoundation

class VideoPlayerState: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    
    public var player: AVPlayer
    private var timeObserver: Any?
    
    init(url: URL, loop: Bool) {
        let asset = AVAsset(url: url)
        let playerItem = AVPlayerItem(asset: asset)
        self.player = AVPlayer(playerItem: playerItem)
        
        if loop {
            player.actionAtItemEnd = .none
            NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
                self.player.seek(to: .zero)
                self.player.play()
            }
        }
        
        asset.loadValuesAsynchronously(forKeys: ["duration"]) { [weak self] in
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: "duration", error: &error)
            
            switch status {
            case .loaded:
                DispatchQueue.main.async {
                    self?.duration = asset.duration.seconds
                }
            case .failed, .cancelled:
                print("Error loading duration: \(error?.localizedDescription ?? "unknown error")")
            default:
                break
            }
        }
        
        player.play()
        isPlaying = true

        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.main) { [weak self] _ in
            self?.updateCurrentTime()
        }
    }
    
    deinit {
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
    }
    
    func togglePlayPause() {
        if isPlaying {
            player.pause()
        } else {
            player.play()
        }
        isPlaying.toggle()
    }
    
    private func updateCurrentTime() {
        currentTime = player.currentTime().seconds
    }
}
