//
//  MovieDetailsVC.swift
//  YassirChallenge
//
//  Created by Walid Ahmed on 03/04/2023.
//

import UIKit
import RxSwift

class MovieDetailsVC: UIViewController {

    
    let movieDetailsViewModel = MovieDetailsViewModel()
    let disposeBag = DisposeBag()

    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bindViewModel()
        movieDetailsViewModel.getMovies(movieId: movieDetailsViewModel.selectedMovie.value.id ?? 0)
    }
    func bindViewModel(){
        // handle back action
        backBtn.rx.tap
            .bind(onNext: {
                self.navigationController?.popViewController(animated: true)
            }).disposed(by: disposeBag)
        
        // show loader
        movieDetailsViewModel.isLoading.asObservable()
            .bind { (loading) in
                if loading {
                    Utils.showLoader(self.view)
                }
                else {
                    Utils.hideLoader()
                }
            }.disposed(by: disposeBag)

        
        // show error
        movieDetailsViewModel.error
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] error in
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)
        
        // get movie details
        movieDetailsViewModel.selectedMovie.asObservable()
            .bind(onNext: {
                (selectedMovie) in
                self.fetchData(selectedMovie: selectedMovie)
            }).disposed(by: disposeBag)
        
    }
    func fetchData(selectedMovie: Movies){
        movieImg.sd_setImage(with: URL(string: "\(Consts.baseURLForPosters)\(selectedMovie.backdropPath ?? "")"))
        titleLbl.text = selectedMovie.title ?? ""
        detailsLbl.text = selectedMovie.overview ?? ""
        let dateConverted = Utils.StringToDateThenToString(dateStr: selectedMovie.releaseDate ?? "", oldFormat: "yyyy-MM-dd", newFormat: "yyyy")
        yearLbl.text = dateConverted
    }

}
