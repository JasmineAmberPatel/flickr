# Photo Finder App

**Photo Finder** is a modern iOS application built with Swift and SwiftUI using the Flickr API. It leverages the MVVM (Model-View-ViewModel) architectural pattern and integrates with the Flickr API to search and display photos.

## Features

- **Search Functionality:** Easily search for photos using keywords and get a list of relevant images from the Flickr API.
- **Photo Details:** Click on any photo from the search results to view more details about the photo, including its owner, title, the date it was posted, and a list of tags associated with the photo.
- **Photo Gallery:** Click the more photos button to see a gallery of all of the images uploaded by a user.
- **Modern UI:** Built using SwiftUI, the app provides a clean and user-friendly interface, offering smooth navigation between views and custom Apple animations.

## MVVM Architecture

This app uses the MVVM architectural pattern. The benefits of this are:

- **Separation of Concerns:** MVVM promotes a clear separation between application's UI (View), the data (Model), and the logic or operations (ViewModel). This separation makes the codebase cleaner and more modular.
- **Reusability:** ViewModels are inherently decoupled from Views, making them reusable across different views.
- **Testability:** With MVVM, you can easily write unit tests for the ViewModel without needing the UI. This allows for more robust and faster testing.
- **Data Binding:** MVVM allows for efficient data binding between Views and ViewModels. This means that any change in the ViewModel is automatically updated in the View and vice versa.

## Asynchronous Programming

All network requests in the app utilize Swift's async/await syntax, making the code more readable and easier to understand. This simplifies asynchronous operations, reduces callback hell, and provides a more straightforward way to handle asynchronous tasks like fetching data from an API.

## Installation

1. Clone or download the repository.
2. Open the project in Xcode.
3. Ensure you have the required Swift and SwiftUI versions.
4. Build and run the application on your preferred simulator or physical device.

https://github.com/JasmineAmberPatel/flickr/assets/50844049/934ec12c-c9dc-45af-bea8-f7b440e50fe4

https://github.com/JasmineAmberPatel/flickr/assets/50844049/b5660ab5-5c6d-4bf4-8ae0-fc66f1e78927
