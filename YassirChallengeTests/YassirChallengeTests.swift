//
//  YassirChallengeTests.swift
//  YassirChallengeTests
//
//  Created by Walid Ahmed on 03/04/2023.
//

import XCTest
import RxSwift
@testable import YassirChallenge

class MoviesViewModelTests: XCTestCase {
    
    var moviesViewModel: MoviesViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        moviesViewModel = MoviesViewModel()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        moviesViewModel = nil
        disposeBag = nil
        super.tearDown()
    }

    func testFetchMovies() {
        // Given
        let expect = expectation(description: "Movies fetched successfully")
        let expectedMoviesCount = 20
        
        // When
        moviesViewModel.getMovies()
        
        // Then
        moviesViewModel.movies.subscribe(onNext: { movies in
            if movies.count == expectedMoviesCount {
                expect.fulfill()
            }
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 20, handler: nil)
    }

    func testLoadNextPage() {
        // Given
        let expect = expectation(description: "Next page loaded successfully")
        
        // When
        moviesViewModel.loadNextPageTrigger.onNext(())
        
        // Then
        moviesViewModel.movies.subscribe(onNext: { movies in
            if movies.count > 20 {
                expect.fulfill()
            }
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 20, handler: nil)
    }

}

class MovieDetailsViewModelTests: XCTestCase {
    
    var movieDetailsViewModel: MovieDetailsViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        movieDetailsViewModel = MovieDetailsViewModel()
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        movieDetailsViewModel = nil
        disposeBag = nil
        super.tearDown()
    }

    func testFetchMovieDetails() {
        // Given
        let expect = expectation(description: "Movie details fetched successfully")
        let expectedMovieId = 10751
        
        // When
        movieDetailsViewModel.getMovies(movieId: expectedMovieId)
        
        // Then
        movieDetailsViewModel.selectedMovie.subscribe(onNext: { movie in
            if movie.id == expectedMovieId {
                expect.fulfill()
            }
        }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 20, handler: nil)
    }

}
