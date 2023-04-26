//
//  VideoCarouselViewApp.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import SwiftUI

@main
struct VideoCarouselApp: App {
    @StateObject private var videoData = VideoData(loadData: loadVideoData)

    var body: some Scene {
        WindowGroup {
            VideoCarouselView(videoURLs: videoData.videos.map { URL(string: $0.url)! })
                .environmentObject(videoData)
        }
    }
}



