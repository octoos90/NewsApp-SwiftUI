//
//  NewsAPIService.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 20/11/24.
//

import Foundation
import UIKit

protocol NewsAPIServiceProtocol {
    func fetchNewsList(from endpoint: NewsAPIService.Endpoint) async throws -> [NewsElement]
    func downloadImage(from urlString: String) async throws -> UIImage
}

final class NewsAPIService: NewsAPIServiceProtocol {
    public static let shared = NewsAPIService()
    private init() {}
    
    private let urlSession = URLSession.shared
    private let baseURL = URL(string: "https://jsonplaceholder.org/")!
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private let imageCache = NSCache<NSString, UIImage>()
    
    public enum APIError: Error {
        case apiError
        case invalidEndpoint
        case invalidResponse
        case noData
        case decodeError
    }
    
    enum Endpoint: String, CustomStringConvertible, CaseIterable {
        case posts
        
        var description: String {
            switch self {
            case .posts:
                return "posts"
            }
        }
    }
    
    func fetchNewsList(from endpoint: Endpoint) async throws -> [NewsElement] {
        let url = baseURL.appendingPathComponent(endpoint.rawValue)
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true),
              let finalURL = urlComponents.url else {
            throw APIError.invalidEndpoint
        }
        let (data, response) = try await urlSession.data(from: finalURL)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.invalidResponse
        }
        
        do {
            return  try jsonDecoder.decode([NewsElement].self, from: data)
        } catch {
            throw APIError.decodeError
        }
    }
    
    func downloadImage(from urlString: String) async throws -> UIImage {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return cachedImage
        }
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidEndpoint
        }
        
        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let image = UIImage(data: data) else {
            throw APIError.noData
        }
        
        imageCache.setObject(image, forKey: urlString as NSString)
        return image
    }
}
