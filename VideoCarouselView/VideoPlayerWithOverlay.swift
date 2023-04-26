//
//  VideoPlayerWithOverlay.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import SwiftUI


struct VideoPlayerWithOverlay: View {
    @ObservedObject var videoPlayerState: VideoPlayerState

    var body: some View {
        ZStack {
            VideoPlayerView(videoPlayerState: videoPlayerState)
                .frame(width: 350, height: 650)
                .cornerRadius(10)
                .shadow(radius: 10)
            
            VideoControlOverlay(isPlaying: $videoPlayerState.isPlaying,
                                currentTime: $videoPlayerState.currentTime,
                                duration: videoPlayerState.duration)
                .frame(width: 350, height: 650)
                .cornerRadius(10)
                .onTapGesture {
                    videoPlayerState.togglePlayPause()
                }
        }
    }
}

