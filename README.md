# Simple News Application - iOS

# Overview

Simple News App is an iOS application that fetches and displays news articles from the Spaceflight News API. The app is designed for both iPhone and iPad, providing a smooth and user-friendly experience.

# Features

# News Feed Screen

- Displays a list of news articles
- Supports search by title or summary
- Implements pagination for loading more articles
- Pull-to-refresh for updating the news feed

# Detail Screen

- Shows full content of the selected news article
- Displays additional details such as publish date
- Swipe navigation to browse previous and next articles

# API Endpoints

News List: https://api.spaceflightnewsapi.net/v4/articles/
Search: https://api.spaceflightnewsapi.net/v4/articles/?title_contains=cricket
Article Details: https://api.spaceflightnewsapi.net/v4/articles/{id}
API Docs: https://api.spaceflightnewsapi.net/v4/docs/

# Tech Stack

- Language: Swift
- Framework: UIKit
- Architecture: MVVM
- Networking: URLSession
- Installation

# Clone the repository:

git clone https://github.com/Damotharan001/SampleNewsApplication.git
cd simple-news-app

# Open the project in Xcode 15

Install dependencies (if using CocoaPods or Swift Package Manager)
Run the app on a simulator or a real device
