Flickr App
Flickr App is a modern iOS application built with Swift and SwiftUI. It leverages the MVVM (Model-View-ViewModel) architectural pattern and integrates with the Flickr API to search and display photos.

Features
Search Functionality: Easily search for photos using keywords and get a list of relevant images from the Flickr API.
Photo Details: Click on any photo from the search results to view more details about the photo, including its owner, title, the date it was posted and a list of tags associated with the photo.
Modern UI: Built using SwiftUI, the app provides a clean and user-friendly interface, offering smooth navigation between views and custom apple animations.

MVVM Architecture
This app uses the MVVM architectural pattern the benefits of this are:

Separation of Concerns: MVVM promotes a clear separation between application's UI (View), the data (Model), and the logic or operations (ViewModel). This separation makes the codebase cleaner and more modular.
Reusability: ViewModels are inherently decoupled from Views, making them reusable across different views.
Testability: With MVVM, you can easily write unit tests for the ViewModel without needing the UI. This allows for more robust and faster testing.
Data Binding: MVVM allows for efficient data binding between Views and ViewModels. This means that any change in the ViewModel is automatically updated in the View and vice versa.

Asynchronous Programming
All network requests in the app utilise Swift's async/await syntax, making the code more readable and easier to understand. This simplifies asynchronous operations, reduces callback hell, and provides a more straightforward way to handle asynchronous tasks like fetching data from an API.

Installation
Clone or download the repository.
Open the project in Xcode.
Ensure you have the required Swift and SwiftUI versions.
Build and run the application on your preferred simulator or physical device.

Given more time I would:
Refactor the way profile information is fetched rather than doing this on the forEach block and doing a request for each photo I would do a batch request for a group of users at a time so there are less API requests and the information is more reliable. I couldn’t find an endpoint which would allow this in the Flickr API documentation so I tried to go down the route of storing all the ownerIds from the getPhotos request in an array and then looping over them and performing a getUserDetails request for each one, then storing all the photo and user information together in a struct which I could then use to show the information together, however I ran out of time to complete this.
Add UI tests which would test the UI works as expected in each of the views.
Add more endpoint tests. I only had time to testGetPhotosSuccess and failure but I would continue and test all of the endpoints.
Add model tests.
Add custom app colours and an app font modifier which could be used to improve the styling.
Add an error alert if a user searches for a term which contains no results.
Add dummy data to the structs which could be used for previews.
