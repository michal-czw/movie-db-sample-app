//
//  MovieDetailsScenePresenterTests.swift
//  TMDB Sample AppTests
//
//  Created by Michał Czwarnowski on 07/06/2024.
//

import XCTest
@testable import TMDB_Sample_App

final class MovieDetailsScenePresenterTests: XCTestCase {

    var spyViewController: MovieDetailsScenePresenterOutput!
    var presenter: MovieDetailsScenePresenterInput!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        spyViewController = SpyMovieDetailsSceneViewController()
        presenter = MovieDetailsScenePresenter(viewController: spyViewController)
    }

    override func tearDownWithError() throws {
        presenter = nil
        spyViewController = nil
        try super.tearDownWithError()
    }

    func testShowResults_GivenMovie_PassViewModelToOutput() throws {
        let movie = givenSampleMovie()
        presenter.showResult(movie)
        let viewModel = try XCTUnwrap((spyViewController as? SpyMovieDetailsSceneViewController)?.viewModel)
        XCTAssertEqual(viewModel.title, "Title")
        XCTAssertEqual(viewModel.description, "Overview")
        XCTAssertEqual(viewModel.releaseDate, "Release date: 2024-06-07")
        XCTAssertEqual(viewModel.rating, "Rating: 10%")
    }

}

private extension MovieDetailsScenePresenterTests {
    
    func givenSampleMovie() -> Movie {
        Movie(
            id: 1,
            title: "Title",
            overview: "Overview",
            posterPath: nil,
            releaseDate: "2024-06-07",
            voteAverage: 1,
            voteCount: 1
        )
    }
    
}

private class SpyMovieDetailsSceneViewController: MovieDetailsScenePresenterOutput {
    private(set) var viewModel: MovieDetailsViewModel?
    private(set) var isFavorite: Bool = false
    
    func showMovieDetails(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    func showFavoriteStatus(isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
    
    func showLoadingIndicator() {}
    
    func showError(message: String) {}
    
    
}
