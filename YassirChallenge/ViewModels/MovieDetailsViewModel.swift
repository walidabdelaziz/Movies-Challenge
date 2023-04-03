//
//  MovieDetailsViewModel.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import Foundation
import RxSwift
import RxCocoa


class MovieDetailsViewModel {
    
    let disposeBag = DisposeBag()
    let selectedMovie = BehaviorRelay<Movies>(value: Movies())
    let isSuccess = BehaviorRelay<Bool>(value: false)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Error>()


    func getMovies(movieId: Int) {
        self.isLoading.accept(true)
        
        NetworkManager.shared.request("\(Consts.Movie_DETAILS)\(movieId)?api_key=\(Consts.API_KEY)") { [weak self] (result: Result<Movies>) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            
            switch result {
            case .success(let response):
                self.selectedMovie.accept(response)
            case .failure(let error):
                // handle error
                print(error)
                self.error.onNext(error)
            }
        }
        
    }
   
}
