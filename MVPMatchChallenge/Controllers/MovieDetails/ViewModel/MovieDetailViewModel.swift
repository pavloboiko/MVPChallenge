//
//  MovieDetailViewModel.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import UIKit

typealias MovieDetailModelOutput = (MovieDetailViewModel.Output) -> ()

/// MovieDetailViewModel Protocol
protocol MovieDetailViewModelProtocol {
    
    var output: MovieDetailModelOutput? { get set }
    func didLoad()
}

/// MovieDetailViewModel Implementation
final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    /// View Output Bindings
    enum Output {
        case showMovieBannerImageView(url: URL)
        case showMovieTitle(title: String)
        case showMovieReleaseDate(releaseDate: NSAttributedString)
        case showMovieDescription(description: String)
        case showMovieRating(rating: String)
        case showMovieLanguage(lang: NSAttributedString)
    }
    
    /// Stored Properties
    var output: MovieDetailModelOutput?
    private var movie: Movie?
    
    /// Computed Properties
    var bannerImageUrl: URL? {
        return URL(string: APIConstants.ImageBaseURL + APIConstants.ImageFullSize + (movie?.posterPath ?? ""))
    }
  
    func didLoad() {
        output?(.showMovieDescription(description: movie?.overview ?? ""))
        output?(.showMovieRating(rating: "\(movie?.voteCount ?? 0)"))
        output?(.showMovieTitle(title: movie?.title ?? ""))
        showMovieLanguage()
        showBannerImage()
        showReleaseDate()
    }
    
    /// Init
    init(_ movie: Movie?) {
        self.movie = movie
    }
    
    /// Private Method
    private func showBannerImage() {
        
        guard let bannerImageUrl = bannerImageUrl else { return }
        output?(.showMovieBannerImageView(url: bannerImageUrl))
    }
    
    private func showMovieLanguage() {
        let locale = NSLocale(localeIdentifier: "en")
        let originalLanguage = movie?.originalLanguage ?? ""
        let languageString = locale.displayName(forKey: .languageCode, value: originalLanguage)
        let languageSuffix = "Language: "
        let attrString = NSMutableAttributedString(string: "\(languageSuffix)\(languageString ?? originalLanguage)")
        attrString.addAttributes([.font : UIFont.boldSystemFont(ofSize: 14)], range: NSRange(location: 0, length: languageSuffix.count))
        output?(.showMovieLanguage(lang: attrString))
    }
    
    private func showReleaseDate() {
        let date = DateTimeUtility.getReleaseDateFromString(dateString: movie?.releaseDate ?? "")
        let dateString = DateTimeUtility.convertToLongDateFormat(from: date) ?? ""
        let releaseDateSuffix = "Release Date: "
        let attrString = NSMutableAttributedString(string: "\(releaseDateSuffix)\(dateString)")
        attrString.addAttributes([.font : UIFont.boldSystemFont(ofSize: 14)], range: NSRange(location: 0, length: releaseDateSuffix.count))
        output?(.showMovieReleaseDate(releaseDate: (attrString)))
    }
}
