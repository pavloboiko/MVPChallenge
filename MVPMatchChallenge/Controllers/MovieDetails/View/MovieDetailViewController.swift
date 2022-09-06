//
//  MovieDetailViewController.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import UIKit

/// MovieDetailViewController
class MovieDetailViewController: UIViewController {

    /// Outlets
    @IBOutlet weak var movieBannerImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    /// Injected Properties
    var viewModel: MovieDetailViewModelProtocol!
    
    
    /// View Lifcycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModelOutput()
        viewModel.didLoad()
        
        movieBannerImageView.addBorderGradients()
    }
    
    /// View Binding
    func bindViewModelOutput() {
        viewModel.output = { [weak self] output in
            
            guard let self = self else { return }
            
            switch output {
            case .showMovieBannerImageView(let url):
                self.movieBannerImageView.kf.setImage(with: url)
            case .showMovieTitle(let title):
                self.movieTitle.text = title
                self.title = title
            case .showMovieReleaseDate(let releaseDate):
                self.movieReleaseDate.attributedText = releaseDate
            case .showMovieDescription(let description):
                self.movieDescription.text = description
            case .showMovieLanguage(let lang):
                self.movieLanguage.attributedText = lang
            case .showMovieRating(let rating):
                self.movieRating.text = rating
            }
        }
    }


}
