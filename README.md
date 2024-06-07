This is a sample app fetching movies from The Movie Database (TMDB).

## App Description
- App fetches Now Playing list and displays it in UICollectionView. 
- It supports adding/removing movies to/from favorite and stores them locally using CoreData.
- MovieDetails displays poster, overview, rating and release date.

## TODO
Project includes a few sample tests showing a general idea. There are mock classes added like `MockAppProvider` and `MockURLProtocol` allowing mocking data and shared instances (e.g. URLSession).

Since there is only one test for MovieDetails presenter checking view model, more tests could be added.
