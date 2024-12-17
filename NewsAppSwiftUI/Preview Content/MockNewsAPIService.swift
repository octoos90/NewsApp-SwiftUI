//
//  MockNewsAPIService.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 17/12/24.
//
import Foundation
import UIKit

// Mock API Service for Preview
class MockNewsAPIService: NewsAPIServiceProtocol {
    func fetchNewsList(from endpoint: NewsAPIService.Endpoint) async throws -> [NewsElement] {
        return [
            NewsElement(
                id: 1,
                slug: "mock-news-1",
                url: "https://example.com/news/1",
                title: "SwiftUI Makes Previews Easy",
                content: "Learn how to make beautiful previews in SwiftUI with mock data!",
                image: nil,
                thumbnail: "https://via.placeholder.com/150",
                status: .published,
                category: .lorem,
                publishedAt: Date(),
                updatedAt: Date(),
                userID: 1
            ),
            NewsElement(
                id: 2,
                slug: "mock-news-2",
                url: "https://example.com/news/2",
                title: "Building News Apps in SwiftUI",
                content: "Step-by-step guide to building a functional news app with SwiftUI.",
                image: nil,
                thumbnail: "https://via.placeholder.com/150",
                status: .published,
                category: .ipsum,
                publishedAt: Date(),
                updatedAt: Date(),
                userID: 2
            )
        ]
    }
    
    func downloadImage(from urlString: String) async throws -> UIImage {
        return UIImage(systemName: "photo") ?? UIImage()
    }
}
