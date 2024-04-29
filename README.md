# TheNews

**Task** :
The application fetches a list of articles from TheGuardian API endpoint where I can get the live data of news feeds. On selecting a news feed from the list, detail news will be presented to the user.

Launch the application and the screen will be presented with news feeds.

**Key takeaways** :
This app is developed with the latest Xcode 15 and dependency target - iOS 17 to support latest concurrency models and SwiftUI NavigationStack. It also supports async await feature. Developed using SwiftUI to render the data in the User Interface.
Built using MVVM Architecture and Unit test cases for testability, scalability and maintainability
Used Async await to fetch data from API endpoint
SnapshotTesting is done using the swift-snapshot-testing package

**Key Features** :
List News feeds
User-friendly interface with SwiftUI
Select News to view the detail feed
Clean and maintainable code architecture using MVVM
Unit testing with XCTestCase for code reliability
Snapshot testing to get a view of how the app works
Supports pull to refresh
Error handling

**Technologies Used :**
SwiftUI
MVVM (Model-View-ViewModel) architecture
Async - Await for API requests
XCTest for unit testing
Unit Tests :
In Xcode, go to the "Product" menu and choose "Test" or use the shortcut (Cmd+U). View the test results in the Xcode test navigator.

**Note** :
Please update the API_KEY in Config.xcconfig file which can be created from https://newsapi.org/register
