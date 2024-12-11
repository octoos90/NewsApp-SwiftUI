//
//  NewsDetailView.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 09/12/24.
//

import SwiftUI

struct NewsDetailView: View {
    let newsItem: NewsElement

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(newsItem.title)
                    .font(.largeTitle)
                    .bold()
                if let thumbnail = newsItem.thumbnail, let url = URL(string: thumbnail) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    .scaledToFit()
                    .cornerRadius(8)
                }
                Text(newsItem.content)
                    .font(.body)
                Spacer()
            }
            .padding()
        }
        .background(Color.white.ignoresSafeArea()) // Set background color
        .navigationTitle(newsItem.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
