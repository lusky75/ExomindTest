//
//  AsyncImageView.swift
//  ExomindTest
//
//  Created by Lucas CHEN on 16/10/2024.
//

import SwiftUI

struct AsyncImageView: View {
    let imageURL: String?

    var body: some View {
        if let validURL = imageURL, let url = URL(string: validURL) {
            // AsyncImage with a valid URL
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    // If the image is not found from the URL or an error occurred, show fallback image with name "no_icon"
                    Image("no_icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                } else {
                    // While loading, show a placeholder
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50) // Set frame as needed
        } else {
            // If URL is nil or invalid, show a placeholder or default image
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.gray) // Placeholder image color
        }
    }
}

#Preview {
    AsyncImageView(imageURL: "https://openweathermap.org/img/wn/01n.png")
}

