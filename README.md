# NewsApp (SwiftUI Version)

This is the SwiftUI version of the **NewsApp**, a sample news application showcasing modern SwiftUI practices with a clean architecture using **MVVM**.

## Features

- Display a list of news articles fetched from a REST API.
- View detailed news articles with images and content.
- Asynchronous image loading with caching.
- Pull-to-refresh functionality.
- Error handling and loading indicators.

## Requirements

- Xcode 14+
- iOS 16+
- Swift 5.7+

## Installation

To run the app locally, follow these steps:

1. Clone the repository:
   ```bash
   git clone https://github.com/octoos90/NewsApp.git
   cd NewsApp
   ```

2. Open the project in Xcode:
   ```
   open NewsAppSwiftUI.xcodeproj
    ```

3. Build and run the project:
   - Select an iOS simulator.
   - Press Cmd + R to run the project.

## Project Structure
```
NewsAppSwiftUI/
|
├── Views/               # SwiftUI views
│   ├── NewsListView.swift      # Main news list screen
│   ├── NewsRowView.swift       # Individual news item row
│   ├── NewsDetailView.swift    # Detailed news article screen
│   ├── NewsHeaderView.swift    # List header view
│
├── ViewModels/          # ViewModels for SwiftUI's MVVM architecture
│   └── NewsViewModel.swift
│
├── Models/              # Data models for API responses
│   └── NewsElement.swift
│
├── Services/            # API-related code
│   └── NewsAPIService.swift    # Handles API requests
│
└── NewsAppSwiftUIApp.swift    # Entry point for the app
```

## Highlights

### SwiftUI Components

#### NewsListView

- Displays a list of news articles fetched from the API.
- Utilizes NavigationStack for seamless navigation to detail views.
- Implements List with custom rows using NewsRowView.

#### NewsRowView

- Displays a single news article row with an image and title.
- Loads images asynchronously using AsyncImage.

#### NewsDetailView:

- Provides a detailed view of a news article with full content.
- Handles large text rendering with ScrollView.

### Modern Features

#### Async/Await:

- Simplifies API calls and image loading with Swift's concurrency model.

#### EnvironmentObject:
- Shares NewsViewModel across views to manage state and data.

#### Pull-to-Refresh:

- Utilizes SwiftUI's .refreshable for a native pull-to-refresh experience.

#### Caching
- Caches downloaded images using NSCache in the NewsAPIService to improve performance and reduce redundant network calls.

## Usage

### Fetch News Articles
The NewsAPIService fetches news articles from the API using the fetchNewsList function:
```swift
Task {
    let news = try await NewsAPIService.shared.fetchNewsList(from: .posts)
}
```

### Display News in List
The NewsListView binds to NewsViewModel for data updates:

```swift
struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationStack {
            List(viewModel.newsData, id: \.id) { newsItem in
                NavigationLink(destination: NewsDetailView(newsItem: newsItem)) {
                    NewsRowView(newsItem: newsItem, viewModel: viewModel)
                }
            }
            .refreshable {
                await viewModel.fetchNews()
            }
        }
    }
}
```

## Contribution
Feel free to fork this repository and submit pull requests. Any contributions, issues, or feature requests are welcome!

## License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/octoos90/NewsApp-SwiftUI/blob/main/LICENSE) file for details.
