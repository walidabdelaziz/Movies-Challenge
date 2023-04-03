# Yassir Challenge - iOS

This project is a simple example of how to fetch movies and display them in a list, and when clicking on any movie in the list, it should navigate to a movie details screen that shows more information about the selected movie. The project uses the following frameworks and technologies:

MVVM design pattern
RxSwift for reactive programming
Alamofire for networking
SDWebImage for image caching and downloading
NVActivityIndicatorView for loader

*Requirements
Xcode 14 or later
Swift 5 or later
CocoaPods

*Installation
Clone the repository or download the zip file and extract it to your preferred location.
Open the terminal and navigate to the project directory.
Run pod install to install the required dependencies.

*Project Structure
The project consists of the following main components:

Models: This directory contains the models that represent the data of the application, such as the Movie model.
NetworkManager: This directory  responsible for handling the network request.
ViewModels: This directory contains the view models that handle the business logic of the application, such as the MoviesViewModel and MovieDetailsViewModel.
Views: This directory contains the views that represent the user interface of the application, such as the MoviesViewController and MovieDetailsViewController.
Helpers: This directory contains any helper classes or extensions that are used throughout the application.
Usage
To fetch and display the movies, open the project in Xcode and run it on a simulator or a real device. The application should display a list of movies on the home screen.

When clicking on any movie in the list, the application should navigate to a movie details screen that displays more information about the selected movie.

*Implementation Details
-Fetching Movies
The MoviesViewController initializes a MoviesViewModel and binds it to the view using RxSwift bindings. The view model is responsible for fetching the movies from the server and preparing them for display in the view.

The view model exposes a movies variable as an observable sequence that emits an array of Movie objects every time the list of movies is updated. It also exposes a loadNextPageTrigger variable as an observable sequence that emits an event every time the user scrolls to the bottom of the list, indicating that the next page of movies should be loaded.

The MoviesViewController subscribes to the movies observable and updates the view accordingly. It also binds the loadNextPageTrigger event to the fetchMovies function in the view model, so that a new page of movies is loaded every time the user scrolls to the bottom of the list.

-Displaying Movie Details
When the user clicks on a movie in the list, the MoviesViewController triggers a segue to the MovieDetailsViewController. The MovieDetailsViewController initializes a MovieDetailsViewModel and binds it to the view using RxSwift bindings.

The view model is responsible for fetching the details of the selected movie from the server and preparing them for display in the view. It exposes a movieDetails variable as an observable sequence that emits a Movie object every time the details of the movie are updated.

The MovieDetailsViewController subscribes to the movieDetails observable and updates the view accordingly.

