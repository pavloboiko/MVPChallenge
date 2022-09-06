//
//  MovieListViewModel.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import Foundation

typealias MoviesViewModelOutput = (MovieListViewModel.Output) -> ()

/// MovieListViewModel Protocol
protocol MovieListViewModelProtocol {

    var dataProvider: MovieListDataProvider! { get }
    var coordinator: MoviesListCoordinator! { get }
    var numberOfMovies: Int { get }
    var output: MoviesViewModelOutput? { get set }
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel
    func didSelectMovie(index : Int)
    func didLoad()
    func tableViewDidReachToEnd()
    func didReset()
    func didSelectFiltering(with date: Date)
    func performCTA()
}

/// MovieListViewModel Implementation
final class MovieListViewModel: MovieListViewModelProtocol {
    
    /// View Output Bindings
    enum Output {
        case reloadMovies
        case showActivityIndicator(show: Bool)
        case showDatePicker(show: Bool)
        case showFilterImage(show: Bool)
        case showError(error: Error)
    }
    
    /// Injected Properties
    var dataProvider: MovieListDataProvider!
    var coordinator: MoviesListCoordinator!
    
    /// Injected Properties Initlizaer
    init(withDataProvider movieListDataProvider: MovieListDataProvider,
         andCoordinator movieListCoordinator: MoviesListCoordinator) {
        self.dataProvider = movieListDataProvider
        self.coordinator = movieListCoordinator
    }
    
    /// Stored Properties
    var output: MoviesViewModelOutput?
    
    /// Observables Properties
    var isFilteringActive: Bool = false {
        didSet {
            output?(.showFilterImage(show: isFilteringActive))
        }
    }
    private var allMovieListViewModels = [MovieListTableCellViewModel]() {
        didSet {
            output?(.reloadMovies)
        }
    }
    private var filteredMovieListViewModels = [MovieListTableCellViewModel]()  {
        didSet {
            output?(.reloadMovies)
        }
    }
    
    /// Computed Properties
    private var movieDataSourceViewModels: [MovieListTableCellViewModel] {
        if isFilteringActive {
            return filteredMovieListViewModels
        }
        return allMovieListViewModels
    }
    
    var numberOfMovies: Int {
        return movieDataSourceViewModels.count
    }
   
    func didLoad() {
        getUpcomingMovies()
    }
    
    func tableViewDidReachToEnd() {
        getUpcomingMovies()
    }
    
    func didSelectFiltering(with date: Date) {
        activateFilter(with: date)
    }
    
    func performCTA() {
        (isFilteringActive) ?  clearFilter() : output?(.showDatePicker(show: true))
    }
    
    func didReset() {
        output?(.showDatePicker(show: false))
    }
    
    
    /// View Input Action Methods
    func getMovieListCellViewModel(index : Int) -> MovieListTableCellViewModel {
        return movieDataSourceViewModels[index]
    }
    
    func getUpcomingMovies() {
        if isFilteringActive == false  { dataProvider.providePaginatedUpcomingMovies() }
    }
    
    /// Private Methods
    private func activateFilter(with date: Date) {
        isFilteringActive = true
        output?(.showDatePicker(show: false))
        let dateString = DateFormatter.shortFormatDateFormatter.string(from: date)
        filteredMovieListViewModels = allMovieListViewModels.filter({ ($0.movie?.releaseDate ?? "") == dateString })
    }

    private func clearFilter() {
        isFilteringActive = false
        filteredMovieListViewModels.removeAll()
    }
    
    func didSelectMovie(index: Int) {
        coordinator.navigateToMovieDetail(withMovie: getMovieListCellViewModel(index: index).movie)
    }
}


/// MovieListDataProviderDelegate Delegate
extension MovieListViewModel: MovieListDataProviderDelegate {
    
    func showLoader(show: Bool) {
        output?(.showActivityIndicator(show: show))
    }
    
    func onSuccess(_ upcomingMovies: UpcomingMovies) {
        guard let results = upcomingMovies.results else { return }
        allMovieListViewModels.append(contentsOf: results.map { MovieListTableCellViewModel.init($0) })
    }
    
    func onFailure(_ error: NetworkError) {
         output?(.showError(error: error))
    }
}

