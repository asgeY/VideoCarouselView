//
//  ContentView.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import SwiftUI
import SwiftUI
import AVKit
import AVFoundation

struct VideoPlayerView: UIViewControllerRepresentable {
    @ObservedObject var videoPlayerState: VideoPlayerState

    func makeUIViewController(context: Context) -> CustomAVPlayerViewController {
        let playerViewController = CustomAVPlayerViewController()

        playerViewController.player = videoPlayerState.player
        playerViewController.videoGravity = .resizeAspectFill
        playerViewController.showsPlaybackControls = false

        return playerViewController
    }

    func updateUIViewController(_ uiViewController: CustomAVPlayerViewController, context: Context) {
        // Empty implementation
    }
}


struct VideoCarousel: View {
    let videoURLs: [URL]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 20) {
                ForEach(videoURLs, id: \.self) { url in
                    let videoPlayerState = VideoPlayerState(url: url, loop: true)
                    VideoPlayerWithOverlay(videoPlayerState: videoPlayerState)
                }
            }
            .padding()
        }
    }
}

struct VideoCarouselView: View {
    let videoURLs: [URL]
    
    var body: some View {
        VStack {
            Text("Watch")
                .font(.largeTitle)
                .bold()
                .padding()
            
            VideoCarousel(videoURLs: videoURLs)
        }
    }
}
func loadPreviewVideoData() -> [Video] {
    var loadedVideos: [Video] = []
    
    if let url = Bundle.main.url(forResource: "video_data", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode([Video].self, from: data)
            loadedVideos = decodedData
        } catch {
            print("Error loading preview video data: \(error)")
        }
    }
    
    return loadedVideos
}



struct VideoCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        let videoData = VideoData(loadData: loadPreviewVideoData)
        VideoCarouselView(videoURLs: videoData.videos.map { URL(string: $0.url)! })
            .environmentObject(videoData)
    }
}



