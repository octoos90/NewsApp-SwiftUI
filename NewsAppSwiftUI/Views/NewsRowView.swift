//
//  NewsRowView.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 09/12/24.
//

import SwiftUI

struct NewsRowView: View {
    let newsItem: NewsElement
    @State private var image: UIImage? = nil
    let viewModel: NewsViewModel

    var body: some View {
        HStack {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } else {
                ProgressView()
                    .frame(width: 80, height: 80)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(newsItem.title)
                    .font(.headline)
                Text(newsItem.content)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text(formattedDate(newsItem.publishedAt))
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .task {
            image = await viewModel.fetchImage(for: newsItem)
        }
    }
    
    // Helper function to format the Date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}
