//
//  ViewController.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import UIKit
import RxSwift

class MoviesVC: UIViewController {

    let moviesViewModel = MoviesViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var moviesTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setMoviesTableView()
        bindViewModel()
        moviesViewModel.getMovies()
    }
    func setMoviesTableView(){
        moviesTV.register(UINib(nibName: "MoviesTVCell", bundle: nil), forCellReuseIdentifier: "MoviesTVCell")
        moviesTV.estimatedRowHeight = UITableView.automaticDimension
        moviesTV.rx.setDelegate(self).disposed(by: disposeBag)
    }

    func bindViewModel(){
        moviesViewModel.movies
            .bind(to: moviesTV.rx.items(cellIdentifier: "MoviesTVCell", cellType: MoviesTVCell.self)) { row, movie, cell in
                cell.movie = movie
            }
            .disposed(by: disposeBag)
        
        // show loader
        moviesViewModel.isLoading.asObservable()
            .bind { (loading) in
                if loading {
                    Utils.showLoader(self.view)
                }
                else {
                    Utils.hideLoader()
                }
            }.disposed(by: disposeBag)
        
        // show error
        moviesViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        // handle next page trigger
        moviesViewModel.bindLoadNextPageTrigger()
            
       // handle selection in tableview
        Observable
            .zip(self.moviesTV.rx.itemSelected, self.moviesTV.rx.modelSelected(Movies.self))
            .bind { [unowned self] indexPath, model in
                let storyboard = UIStoryboard(name: "Movies", bundle: nil)
                let MovieDetailsVC = storyboard.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
                MovieDetailsVC.movieDetailsViewModel.selectedMovie.accept(model)
                self.navigationController?.pushViewController(MovieDetailsVC, animated: true)
            }
            .disposed(by: disposeBag)
    }

}

extension MoviesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastElement = moviesViewModel.movies.value.count - 1
        if indexPath.row == lastElement {
            moviesViewModel.loadNextPageTrigger.onNext(())
        }
    }
}
