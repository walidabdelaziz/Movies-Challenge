//
//  MoviesViewModel.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import Foundation
import RxSwift
import RxCocoa


class MoviesViewModel {
    
    let disposeBag = DisposeBag()
    var currentPage = 1
    var totalPages = 1

    let movies = BehaviorRelay<[Movies]>(value: [])
    let isSuccess = BehaviorRelay<Bool>(value: false)
    let isLoading = BehaviorRelay<Bool>(value: false)
    let error = PublishSubject<Error>()
    let loadNextPageTrigger = PublishSubject<Void>()


    func getMovies() {
        guard !isLoading.value && currentPage <= totalPages else { return }
        self.isLoading.accept(true)
        
        NetworkManager.shared.request("\(Consts.Movies)&page=\(currentPage)") { [weak self] (result: Result<MoviesModel>) in
            guard let self = self else { return }
            self.isLoading.accept(false)
            
            switch result {
            case .success(let response):
                
                self.currentPage += 1
                self.totalPages = response.totalPages ?? 1
                self.movies.accept((self.movies.value) + (response.results ?? []))
            case .failure(let error):
                // handle error
                print(error)
                self.error.onNext(error)
            }
        }
        
    }
    func bindLoadNextPageTrigger() {
        loadNextPageTrigger
            .subscribe(onNext: { [weak self] in
                self?.getMovies()
            }).disposed(by: disposeBag)
    }
    
}
