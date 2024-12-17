//
//  NewsListView.swift
//  NewsAppSwiftUI
//
//  Created by Octo Siswardhono on 26/11/24.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel: NewsViewModel
    
    init(viewModel: NewsViewModel? = nil) {
        if let viewModel {
            _viewModel = StateObject(wrappedValue: viewModel)
        } else {
            _viewModel = StateObject(wrappedValue: NewsViewModel())
        }
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading News...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(viewModel.newsData, id: \.id) { newsItem in
                        NavigationLink(destination: NewsDetailView(newsItem: newsItem)) {
                            NewsRowView(newsItem: newsItem, viewModel: viewModel)
                        }
                        .listRowBackground(Color.white) // Ensure row background is white
                        .buttonStyle(PlainButtonStyle()) // Disable tap overlay effect
                    }
                }
            }
            .navigationTitle("News")
            .task {
                await viewModel.fetchNews()
            }
            .refreshable {
                await viewModel.fetchNews()
            }
            .background(Color.white.ignoresSafeArea()) // Set background color
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        let mockService = MockNewsAPIService()
        let mockViewModel = NewsViewModel(apiService: mockService)
        
        NewsListView(viewModel: mockViewModel)
    }
}
