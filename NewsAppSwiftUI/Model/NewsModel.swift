//
//  NewsModel.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 20/11/24.
//

import Foundation

// MARK: - NewsElement
struct NewsElement: Codable, Identifiable {
    let id: Int
    let slug: String
    let url: String
    let title: String
    let content: String
    let image: String?
    let thumbnail: String?
    let status: Status
    let category: Category
    let publishedAt: Date
    let updatedAt: Date
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case id, slug, url, title, content, image, thumbnail, status, category, publishedAt, updatedAt
        case userID = "userId"
    }
}

// MARK: - Category
enum Category: String, Codable {
    case elementum = "elementum"
    case ipsum = "ipsum"
    case jsonplaceholder = "jsonplaceholder"
    case lorem = "lorem"
    case rutrum = "rutrum"
}

// MARK: - Status
enum Status: String, Codable {
    case published = "published"
}

// MARK: - Custom Decoding for Dates
extension NewsElement {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        slug = try container.decode(String.self, forKey: .slug)
        url = try container.decode(String.self, forKey: .url)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        image = try? container.decode(String.self, forKey: .image)
        thumbnail = try? container.decode(String.self, forKey: .thumbnail)
        status = try container.decode(Status.self, forKey: .status)
        category = try container.decode(Category.self, forKey: .category)
        
        let publishedAtString = try container.decode(String.self, forKey: .publishedAt)
        let updatedAtString = try container.decode(String.self, forKey: .updatedAt)

        // Convert date strings to `Date` using a formatter
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // Adjust to your API's format
        publishedAt = formatter.date(from: publishedAtString) ?? Date()
        updatedAt = formatter.date(from: updatedAtString) ?? Date()

        userID = try container.decode(Int.self, forKey: .userID)
    }
}

