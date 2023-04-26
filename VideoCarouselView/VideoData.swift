//
//  VideoData.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import Foundation

struct Video: Codable, Identifiable {
    let id = UUID()
    let url: String
    
    enum CodingKeys: String, CodingKey {
            case url
        }
}

class VideoData: ObservableObject {
    @Published var videos: [Video] = []

    init(loadData: @escaping () -> [Video]) {
        self.videos = loadData()
    }
}

func loadVideoData() -> [Video] {
    var loadedVideos: [Video] = []
    
    if let url = Bundle.main.url(forResource: "video_data", withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode([Video].self, from: data)
            loadedVideos = decodedData
        } catch {
            print("Error loading video data: \(error)")
        }
    }
    
    return loadedVideos
}


