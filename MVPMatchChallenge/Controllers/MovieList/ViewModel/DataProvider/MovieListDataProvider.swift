//
//  MovieListDataProvider.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation

/// Delegates Protocol
protocol MovieListDataProviderDelegate: AnyObject {
    
    func onSuccess(_ upcomingMovies: UpcomingMovies)
    func onFailure(_ error: NetworkError)
    func showLoader(show: Bool)
}


/// MovieListDataProvider Protocol
protocol MovieListDataProvider {

    func providePaginatedUpcomingMovies()
    var delegate: MovieListDataProviderDelegate? { get set }
}

/// MovieListDataProvider Protocol Implementation
class MovieListDataProviderImpl: MovieListDataProvider {
    
    /// Injected Properties
    var movieService: MovieListService!
    
    /// Private Properties
    private var pageCount = 1
    private var totalPages: Int = 1
    private var isFetching = false
    
    /// Computed Properties
    weak var delegate: MovieListDataProviderDelegate?
    
    /// Methods
    func providePaginatedUpcomingMovies() {
        
        if pageCount <= totalPages && isFetching == false {

            isFetching = true
            delegate?.showLoader(show: isFetching)
            movieService.fetchMovies(forPage: pageCount) { [weak self] (result) in
                
                guard let self = self else { return }
        
                self.isFetching = false
                self.delegate?.showLoader(show: self.isFetching)
                
                switch result {
                    
                case .success(let upcomingMovies):
                    self.pageCount = upcomingMovies.page + 1
                    self.totalPages = upcomingMovies.totalPages 
                    self.delegate?.onSuccess(upcomingMovies)
                    
                case .failure(let error):
                    self.delegate?.onFailure(error)

                }
            }
        }
    }
    
}
