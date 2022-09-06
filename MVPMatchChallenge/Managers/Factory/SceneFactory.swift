//
//  SceneFactory.swift
//  MVPMatchChallenge
//
//  Created by Pavlo Boiko on 2022/9/5.
//

import UIKit

enum SceneType {
    case MovieList
    case MovieDetail
}

class SceneFactory {
    
    private static var sharedSceneFactory = SceneFactory()
    
    class func shared() -> SceneFactory {
        return sharedSceneFactory
    }
    
    func getScene(sceneType: SceneType, withMovie movie: Movie? = nil) -> UIViewController {
        switch sceneType {
        case .MovieList:
            return getMovieListScene()
        case .MovieDetail:
            return getMovieDetailsScene(withMovie: movie)
        }
    }

    /// Builds MovieListViewController and binds coordinator, data provider and viewmodels with it.
    ///
    /// - Returns: MovieListViewController
    private func getMovieListScene() -> MovieListViewController {
        
        let storyboard = UIStoryboard(name: UIStoryboard.Name.moviesList.rawValue, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: UIViewController.Name.moviesList.rawValue) as! MovieListViewController
        
        let dataProvider = MovieListDataProviderImpl()
        dataProvider.movieService = MovieListServiceImpl()
        let coordinator = MoviesListCoordinatorImpl(view: viewController)
        
        let viewModel = MovieListViewModel(withDataProvider: dataProvider, andCoordinator: coordinator)
        
        dataProvider.delegate = viewModel
        viewModel.dataProvider = dataProvider
        viewController.viewModel = viewModel
        return viewController
    }

    /// Builds MovieDetailViewController and binds coordinator, data provider and viewmodels with it.
    ///
    /// - Returns: MovieDetailViewController
    private func getMovieDetailsScene(withMovie movie: Movie?) -> MovieDetailViewController {
        
        let storyboard = UIStoryboard(name: UIStoryboard.Name.moviesDetails.rawValue, bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: UIViewController.Name.moviesDetails.rawValue) as! MovieDetailViewController
        let viewModel = MovieDetailViewModel(movie)
        viewController.viewModel = viewModel
        
        return viewController
    }

}
