//
//  VideoOverlay.swift
//  VideoCarouselView
//
//  Created by AsgeY on 4/25/23.
//

import SwiftUI

struct VideoControlOverlay: View {
    @Binding var isPlaying: Bool
    @Binding var currentTime: Double
    let duration: Double

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("\(Int(currentTime)) / \(Int(duration))")
                    .foregroundColor(.white)
                    .padding(5)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(5)
                    .padding(.trailing)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(isPlaying ? Color.clear : Color.black.opacity(0.5))
        .onTapGesture {
            isPlaying.toggle()
        }
    }
}



