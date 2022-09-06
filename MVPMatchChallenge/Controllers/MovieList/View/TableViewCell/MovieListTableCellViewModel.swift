//
//  MovieListTableCellViewModel.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation

/// MovieListViewModel

struct MovieListTableCellViewModel {
    
     /// Properties
    var movieTitleText: String
    var movieDescription: String
    var moviePosterUrl: String
    var movieReleaseDate: String
    var movie: Movie?
    
    init(_ movie: Movie?) {
        
        self.movie = movie
        self.movieTitleText = movie?.title ?? ""
        self.movieDescription = movie?.overview ?? ""
        self.moviePosterUrl = APIConstants.ImageBaseURL + APIConstants.ImagePreviewSize + (movie?.posterPath ?? "")
        
        let date = DateTimeUtility.getReleaseDateFromString(dateString: movie?.releaseDate ?? "")
        self.movieReleaseDate = DateTimeUtility.convertToLongDateFormat(from: date) ?? ""
    }
    
}
