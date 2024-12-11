//
//  NewsViewModel.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 26/11/24.
//

import Foundation
import SwiftUI

@MainActor
final class NewsViewModel: ObservableObject {
    @Published var newsData: [NewsElement] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiService: NewsAPIServiceProtocol
    private var imageCache: [String: UIImage] = [:]
    
    init(apiService: NewsAPIServiceProtocol = NewsAPIService.shared) {
        self.apiService = apiService
    }

    func fetchNews() async {
        isLoading = true
        do {
            let newsList = try await apiService.fetchNewsList(from: .posts)
            newsData = newsList
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func fetchImage(for news: NewsElement) async -> UIImage? {
        if let cachedImage = imageCache[news.title] {
            return cachedImage
        }
        do {
            let image = try await apiService.downloadImage(from: news.thumbnail ?? "")
            imageCache[news.title] = image
            return image
        } catch {
            print("Failed to fetch image for \(news.title): \(error)")
            return nil
        }
    }
    
    func cachedImage(for news: NewsElement) -> UIImage? {
        return imageCache[news.title]
    }
}
